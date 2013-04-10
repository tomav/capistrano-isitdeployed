require 'capistrano/isitdeployed/version'
require 'capistrano/isitdeployed/config'
require 'capistrano/isitdeployed/debug'
require 'capistrano/logger'
require 'rest_client'
require 'json'

module Capistrano
  module Isitdeployed

    def self.timestamp
      return Time.now.utc.strftime("%Y%m%d%H%M%S")        
    end

    def self.load_user_config
      return YAML.load_file(CONFIG_DEST)      
    end

    def self.load_into(configuration)
      configuration.load do
  
        # task hooks
        before 'deploy',               'isit:deploy'
        after  'deploy',               'isit:status:success'
        after  'deploy:rollback',      'isit:status:rollback'
        after  'isit:status_success',  'isit:update'
        after  'isit:status_rollback', 'isit:update'

        # task definitions
        namespace :isit do
          # TODO: generate a pre-configured file using command line arguments
          # cap isit-setup -project_id=x -api_secret=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
          desc "Creates a configuration file"
          task :setup do
            if File.exists?(CONFIG_DEST)
              logger.trace "WARNING: A configuration file already exists. Remove it before running setup again."
            else 
              path      = File.dirname(File.expand_path(__FILE__))
              source    = path + '/isitdeployed/' + CONFIG_SRC
              dest      = CONFIG_DEST
              FileUtils.cp source, dest
              logger.trace "IsItDeployed > #"
              logger.trace "IsItDeployed > # A configuration file '#{dest}' has been created."
              logger.trace "IsItDeployed > # Please edit this file before your next deploy."
              logger.trace "IsItDeployed > #"
            end
          end

          desc "Creates a new deploy using the API"
          task :deploy do
            if File.exists?(CONFIG_DEST)
              config  = Capistrano::Isitdeployed.load_user_config
              started = Capistrano::Isitdeployed.timestamp
              set(:stage, "my platform") unless exists?(:stage)
              RestClient.post(ENDPOINT + "/p/#{config['project_id']}/d", JSON.generate({ :status => 1, :platform => "#{stage}", :release => "#{release_name}", :started => started, :token => config['api_secret'], :version => VERSION }), :content_type => :json, :accept => :json, :timeout => 5, :open_timeout => 5){ |response, request, result| response
                case response.code
                when 201
                  logger.trace "IsItDeployed > New deploy created for #{application} to #{stage} with version: #{release_name}"
                  logger.trace "IsItDeployed > URL is #{ENDPOINT}/p/#{config['project_id']}"
                  json = JSON.parse(response)
                  if json['latest_version'] > VERSION
                    logger.trace "IsItDeployed > WARNING: Your 'capistrano-isitdeployed' gem is outdated. Consider upgrade to #{json['latest_version']}"                  
                  end
                  set(:isitdeployed_did,     json['deploy_id'])
                  set(:isitdeployed_started, started)
                  set(:isitdeployed_created, 1)
                when 401
                  logger.trace "IsItDeployed > ERROR: Invalid 'api_secret'. Check your '#{CONFIG_DEST}'"                
                  set(:isitdeployed_created, 0)
                when 404
                  logger.trace "IsItDeployed > ERROR: Invalid 'project_id'. Check your '#{CONFIG_DEST}'"                
                  set(:isitdeployed_created, 0)
                else
                  logger.trace "IsItDeployed > ERROR: Can't create deploy, server returned code #{response.code}"
                  set(:isitdeployed_created, 0)
                end
              }
            else 
              logger.trace "IsItDeployed > WARNING: No configuration file found, please run cap 'isit:setup'"
              set(:isitdeployed_created, 0)
            end
          end

          namespace :status do
            desc "Set the deploy status to success locally"
            task :success do
              set(:isitdeployed_status, 2)
            end

            desc "Set the deploy status to rollback locally"
            task :rollback do
              set(:isitdeployed_status, 3)
            end
          end

          desc "Updates deploy status using the API (success or rollback)"
            task :update do
            if isitdeployed_created === 1
              config    = Capistrano::Isitdeployed.load_user_config
              stopped   = Capistrano::Isitdeployed.timestamp
              duration  = stopped.to_i - isitdeployed_started.to_i
              RestClient.put(ENDPOINT + "/p/#{config['project_id']}/d/#{isitdeployed_did}", JSON.generate({ :status => isitdeployed_status, :stopped => stopped, :duration => duration, :token => config['api_secret'] }), :content_type => :json, :accept => :json, :timeout => 5, :open_timeout => 5){ |response, request, result| response
                case response.code
                when 204
                  logger.trace "IsItDeployed > Deploy ##{isitdeployed_did} has been updated for #{application} to #{stage}."
                when 401
                  logger.trace "IsItDeployed > ERROR: Invalid 'api_secret'. Check your '#{CONFIG_DEST}'"                
                when 404
                  logger.trace "IsItDeployed > ERROR: Invalid 'project_id'. Check your '#{CONFIG_DEST}'"                
                else
                  logger.trace "IsItDeployed > ERROR: Can't create deploy, server returned #{response.code}"
                end
              }                      
            end
          end
        end
      end
    end
  end
end

Capistrano.plugin :cdm, Capistrano::Isitdeployed

if Capistrano::Configuration.instance
  Capistrano::Isitdeployed.load_into(Capistrano::Configuration.instance(:must_exist))
end