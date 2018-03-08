require 'yaml'
require 'bunny'
require 'json'
require 'csv'
require 'logger'
require 'rspec/core/rake_task'
require 'byebug'
require_relative 'init_helper/load_helper'

desc 'initialize'
task default: ['run']

task :run do
  ROOT_DIR = __dir__
  @environment = ENV['environment'] ? ENV['environment'] : 'development'
  Rake::Task['load_dependencies'].invoke
  Rake::Task['config'].invoke
  Rake::Task['logging'].invoke
  Rake::Task['config_rabbit'].invoke
  Main.new.process
end

RSpec::Core::RakeTask.new(:spec)

task :config_rabbit do
  RABBITMQ_CONFIG = LoadHelper.build_config('config/rabbitmq.yml'.freeze, @environment)
end

task :config do
  CONFIG = LoadHelper.build_config('config/config.yml'.freeze, @environment)
end

task :load_dependencies do
  require_pattern = File.join(ROOT_DIR, '**/*.rb')
  @failed = []
  LoadHelper.include_require_relativies require_pattern
end

task :logging do
  @logger = Logger.new("| tee #{ROOT_DIR}/log/log")
  @logger.level = LoadHelper.find_log_level(CONFIG[:log_level])
  @logger.datetime_format = '%Y-%m-%d %H:%M:%S%z '
  LOGGER = @logger
end
