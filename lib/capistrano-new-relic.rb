# encoding: utf-8
require 'capistrano'
require 'colored'

def _cset(name, *args, &block)
  unless exists?(name)
    set(name, *args, &block)
  end
end

Capistrano::Configuration.instance.load do
  _cset(:new_relic_api_key) {
    abort "Please specify the new_relic_api_key either in :new_relic_api_key or in environment NEW_RELIC_API_KEY".red if ENV['NEW_RELIC_API_KEY'].nil?
    ENV['NEW_RELIC_API_KEY']
  }

  _cset(:new_relic_app_name) { abort "Please specify :newrelic_app_name".red }
  _cset(:deploy_env) { abort "Please specify :deploy_env, needed for sensible description".red }
  _cset(:application) { abort "Please specify :application, needed for sensible description".red }
  _cset(:branch) { abort "Please specify :branch, needed for sensible description".red }

  namespace :newrelic do
    desc "Notify New Relic of deployment"
    task :notify do
        local_user = run_locally("git config user.name").strip
        local_user_email = run_locally("git config user.email").strip
        current_rev = capture("cd #{latest_release}; git rev-parse HEAD").strip()
        previous_rev = capture("cd #{previous_release}; git rev-parse HEAD").strip()
        changelog = capture("cd #{latest_release}; git log --oneline #{previous_rev}..#{current_rev}")
        tmp_file_name = current_rev + '-' + previous_rev + '-changelog'
        File.open(tmp_file_name, 'w') { |file| file.write("deployment[changelog]=#{changelog}")}
        run_locally %Q{\
            curl -s -H "x-api-key:#{new_relic_api_key}"\
            -d "deployment[app_name]=#{new_relic_app_name}"\
            -d "deployment[description]=Deploy #{application}/#{branch} to #{deploy_env}"\
            -d "deployment[user]=#{local_user} <#{local_user_email}>"\
            -d "deployment[revision]=#{current_rev}"\
            --data-binary @#{tmp_file_name}\
            https://rpm.newrelic.com/deployments.xml\
            >nul 2>&1\
        }
        File.unlink(tmp_file_name)
    end
  end
end
