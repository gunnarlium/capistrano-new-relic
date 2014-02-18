$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require 'capistrano-new-relic/version'

Gem::Specification.new do |s|
  s.name        = 'capistrano-new-relic'
  s.version     = Capistrano::NewRelic::VERSION
  s.authors     = ['Gunnar Lium']
  s.email       = ['post@gunnarlium.com']
  s.homepage    = 'http://github.com/gunnarlium/capistrano-new-relic'
  s.summary     = 'Capistrano New Relic recipe'
  s.description = 'Capistrano recipe to notify New Relic after deploying code'
  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.license       = 'MIT'

  s.add_dependency 'capistrano', '>= 2.0', '< 3.0'
  s.add_dependency 'colored'
end
