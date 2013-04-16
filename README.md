# capistrano-isitdeployed

This plugin works as an interface between your [Capistrano](http://capistranorb.com/) deployments and [www.isitdeployed.com](http://www.isitdeployed.com) which gives you :
* deployments counter for your projects
* a deployment status page for you and your team which displays current deploy status (does not nead page reload for updates)
* soon: deploys statistics

And it's Free.

If you already use Capistrano, welcome on board!
If not, you should! :-)

Has been tested with Rails3 and Symfony2 projects.

## Requirements
* some gems but dependencies are managed automatically when you install capistrano-isitdeployed
* ruby1.x**-dev** (otherwise you will get `no such file to load -- mkmf (LoadError)`)
* log level must display `logger.trace`

## Installation

* install the gem
* create a project on [www.isitdeployed.com](http://www.isitdeployed.com) with a valid email address
* you will receive the instructions to enable capistrano-isitdeployed in your project

## Detailed installation

### 1. install gem 

##### Rails users

in your `Gemfile`, add:  
`gem 'capistrano-isitdeployed'`  
and run:  
`bundle`

##### Others

`gem install capistrano-isitdeployed`  
(you may have to use sudo)

### 2. at the top of `config/deploy.rb`, add the lines you received on your email:  
    # isitdeplopyed settings
    require 'capistrano/isitdeployed'
    set :isitdeployed_project_id, 'x'
    set :isitdeployed_api_secret, 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

### 3. Deploy!
cap deploy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

