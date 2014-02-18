# capistrano-new-relic

Capistrano v2 recipe to notify New Relic of deployments.


This gem is inspired by https://github.com/martinj/capistrano-jenkins.

Your your name and email os fetched from git config, so make sure you have
valid values for `user.name` and `user.email`.

__Note:__ Capistrano 3 is completely incompatible with Capistrano 2. If you are using Capistrano 3 you can use [cap-newrelic](https://github.com/rjocoleman/cap-newrelic) (the configuration is not directly compatible).

## Installation

	gem install capistrano-new-relic

## Options

**:new_relic_api_key**

API key to use when posting to New Relic.

By default it will check for the API key in the environment variable NEW_RELIC_API_KEY.

## Usage

Include the recipe

	require 'capistrano-new-relic'

Set required parameters

	set :new_relic_app_name, "My Application"
	set :new_relic_app_id, "XXXXXXXXXX"
	set :branch, "master"
	set :deploy_env, "production"
	set :new_relic_api_key, "<yoursecretapikey>"


Add the task, typically after deploy

	after "deploy:update_code", "newrelic:notify"
