# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/isitdeployed/version'
require 'yaml'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-isitdeployed"
  gem.version       = Capistrano::Isitdeployed::VERSION
  gem.authors       = ["Thomas VIAL"]
  gem.email         = ["rubygems@ifusio.com"]
  gem.description   = %q{Capistrano plugin for IsItDeployed service, which provides capistrano statistics - www.isitdeployed.com}
  gem.summary       = %q{Capistrano plugin for IsItDeployed service, which provides capistrano statistics - www.isitdeployed.com}
  gem.homepage      = "https://github.com/tomav/capistrano-isitdeployed"

  gem.files         = YAML.load_file('Manifest.yml')
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('capistrano', '>= 2.12.0')
  gem.add_dependency('rest-client', '>= 1.6.7')
  gem.add_dependency('json', '>= 1.7.7')
end
