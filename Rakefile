require 'bundler'
require 'rspec/core/rake_task'

desc('Run all unit tests')
RSpec::Core::RakeTask.new(:unit) do |spec|
  spec.pattern = FileList['spec/unit/**/*_spec.rb']
end

desc('Run all integration tests')
RSpec::Core::RakeTask.new(:integration) do |spec|
  spec.pattern = FileList['spec/integration/**/*_spec.rb']
end

desc('By default run all unit tests')
task :default => [:unit]

desc('Run all unit and integration tests')
task :all => [:unit, :integration]