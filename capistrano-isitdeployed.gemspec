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
  gem.description   = %q{This is a pre-alpha build for test purpose.}
  gem.summary       = %q{This is a pre-alpha build for test purpose.}
  gem.homepage      = "http://tvi.al"

  gem.files         = YAML.load_file('Manifest.yml')
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('rest-client', '>= 1.6.7')
end
