# capistrano-isitdeployed

This plugin works as an interface between your [Capistrano](http://capistranorb.com/) deployments and [www.isitdeployed.com](http://www.isitdeployed.com) which gives you :
* deployments counter for your projects
* a deployment status page for you and your team which displays current deploy status (does not nead page reload for updates)
* soon : deploys statistics

And it's Free.

If you already use Capistrano, welcome on board!
If not, you should! :-)

Has been tested with Rails3 and Symfony2 projects.

## Installation

* install the gem
* create a project on [www.isitdeployed.com](http://www.isitdeployed.com) with a valid email address
* you will receive the instructions to enable capistrano-isitdeployed in you deploy.rb

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

### 2. at the top of `config/deploy.rb`, add:  
`require 'capistrano/isitdeployed'`

### 3. generate config file running:
`cap isit:setup`

### 4. edit `config/isitdeployed.yml` config file
Configure `project_id` and `api_secret` with values received on your email

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

