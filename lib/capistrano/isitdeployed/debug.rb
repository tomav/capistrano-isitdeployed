module Capistrano
  module Isitdeployed
    module Debug
      def self.load_into(configuration)
        configuration.load do
          ############################################################
          # /!\ DEBUG ONLY
          # Do not use unless you want to poluate your data
          namespace :isit do
            namespace :check do
              desc "Check feature for success"
              task :success do
                find_and_execute_task("isit:deploy")
                sleep(5)
                find_and_execute_task("isit:status:success")
                find_and_execute_task("isit:update")
              end

              desc "Check feature for rollback"
              task :rollback do
                find_and_execute_task("isit:deploy")
                sleep(5)
                find_and_execute_task("isit:status:rollback")
                find_and_execute_task("isit:update")
              end
            end
            ############################################################
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  Capistrano::Isitdeployed::Debug.load_into(Capistrano::Configuration.instance(:must_exist))
end