# Tasks
namespace :foreman_vmwareannotations do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanVmwareannotations'
  Rake::TestTask.new(:foreman_vmwareannotations) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_vmwareannotations do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_vmwareannotations) do |task|
        task.patterns = ["#{ForemanVmwareannotations::Engine.root}/app/**/*.rb",
                         "#{ForemanVmwareannotations::Engine.root}/lib/**/*.rb",
                         "#{ForemanVmwareannotations::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_vmwareannotations'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_vmwareannotations']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_vmwareannotations', 'foreman_vmwareannotations:rubocop']
end
