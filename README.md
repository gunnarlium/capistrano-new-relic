# capistrano-new-relic

Capistrano recipe to notify New Relic of deployments.

This gem is inspired by https://github.com/martinj/capistrano-jenkins.

Your your name and email os fetched from git config, so make sure you have
valid values for `user.name` and `user.email`.

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

	set :application, "My Application"
	set :branch, "master"
	set :deploy_env, "production"
	set :new_relic_api_key, "<yoursecretapikey>"


Add the task, typically after deploy

	after "deploy:update_code", "newrelic:notify"
