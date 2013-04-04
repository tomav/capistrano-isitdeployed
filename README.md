# capistrano-isitdeployed

This plugin works as an interface between your [Capistrano](http://capistranorb.com/) deployments and [www.isitdeployed.com](http://www.isitdeployed.com) which gives you :
* deployments counter for your projects
* a deployment status page for you and your team which displays current deploy status (does not nead page reload for updates)
* soon : deploys statistics

If you already use Capistrano, welcom on board!
If not, you should! :-)

## Installation

### Rails users

Add this line to your application's Gemfile:

    gem 'capistrano-isitdeployed'

And then execute:

    $ bundle

#### Not a rails user ? No problem

Install it yourself as:

    $ gem install capistrano-isitdeployed

Has been tested with rails Rails3 and Symfony2 projects.

## Usage

* install the gem
* create a project on [www.isitdeployed.com](http://www.isitdeployed.com) with a valid email address
* you will receive the instructions to enable capistrano-isitdeployed in you deploy.rb

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
