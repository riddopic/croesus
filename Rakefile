
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'

desc 'Run tests'
RSpec::Core::RakeTask.new(:spec)

desc 'Run Rubocop on the gem'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb', 'spec/**/*.rb']
  task.fail_on_error = true
end

YARD::Config.load_plugin 'redcarpet-ext'
YARD::Rake::YardocTask.new do |t|
  t.files = ['**/*.rb', '-', 'README.md', 'CHANGELOG.md', 'LICENSE.txt']
  t.options = ['--markup-provider=redcarpet', '--markup=markdown']
end

desc 'Build documentation'
task doc: [:yard]

task default: [:spec, :rubocop, :build, :install]

