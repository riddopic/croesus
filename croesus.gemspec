# encoding: UTF-8

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'croesus/version'

Gem::Specification.new do |s|
  s.name        = 'croesus'
  s.version     = Croesus::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = 'Council with the Delphic oracle, King of Lydia'
  s.description = 'Ruby REST client for Delphix virtual database appliance'
  s.authors     = ['Stefano Harding']
  s.email       = 'riddopic@gmail.com'
  s.homepage    = 'https://github.com/riddopic/croesus'
  s.license     = 'Apache 2.0'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split

  s.add_dependency 'awesome_print'
  s.add_dependency 'command_line_reporter'
  s.add_dependency 'addressable',                    '>= 2.3.6'
  s.add_dependency 'rest-client',                    '>= 1.6.7'
  s.add_dependency 'json',                           '>= 1.7.7'

  s.add_development_dependency 'yard',               '>= 0.8.6'
  s.add_development_dependency 'github-markup',      '>= 1.3.0'
  s.add_development_dependency 'redcarpet',          '>= 3.2.0'
  s.add_development_dependency 'yard-redcarpet-ext', '>= 0.0.3'
  s.add_development_dependency 'rubocop',            '>= 0.26.0'
  s.add_development_dependency 'rake',               '>= 10.3.2'
  s.add_development_dependency 'coveralls',          '>= 0.7.1'
  s.add_development_dependency 'rspec',              '>= 3.1.0'
  s.add_development_dependency 'fuubar',             '>= 2.0.0'
  s.add_development_dependency 'timecop',            '>= 0.7.1'
end
