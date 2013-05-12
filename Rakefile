require "bundler/gem_tasks"
Bundler::GemHelper.new(Dir.pwd).instance_eval do
  desc "Build #{name}-#{version}.gem into the pkg directory"
  task 'build' do
    build_gem
  end

  desc "Build and install #{name}-#{version}.gem into system gems"
  task 'install' do
    install_gem
  end

  task :default => [:spec]
  begin
    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new(:spec) do |spec|
      spec.pattern = 'spec/**/*_spec.rb'
      spec.rspec_opts = ['-cfs']
    end
  rescue LoadError => e
  end
end
