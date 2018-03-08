# frozen_string_literal: true

require 'byebug'
require 'yaml'
require 'bunny'
require 'json'
require 'csv'
require 'logger'
require_relative '../init_helper/load_helper'

ROOT_DIR = File.expand_path('../', __dir__)
require_pattern = File.join(ROOT_DIR, 'app/**/*.rb')
LoadHelper.include_require_relativies require_pattern

RABBITMQ_CONFIG = LoadHelper.build_config('config/rabbitmq.yml', 'test')
CONFIG = LoadHelper.build_config('config/config.yml', 'test')

RSpec.configure do |config|
  config.color = true
end
