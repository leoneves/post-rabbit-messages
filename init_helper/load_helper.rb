# frozen_string_literal: true

class LoadHelper
  def self.include_require_relativies(require_pattern)
    Dir.glob(require_pattern).each do |f|
      next if f.include?('spec')
      require_relative f.gsub("#{__dir__}/", '')
    end
  end

  def self.build_config(path_file, environment)
    yaml_config = LoadHelper.load_yaml_config(path_file, environment)
    LoadHelper.symbolize_config yaml_config
  end

  def self.find_log_level(str_level)
    levels = { info: Logger::INFO, debug: Logger::DEBUG }
    levels[str_level.to_sym]
  end

  def self.symbolize_config(yaml_config)
    symbolize_config = {}
    yaml_config.each do |key, value|
      symbolize_config[key.to_sym] = value
    end
    symbolize_config
  end

  def self.load_yaml_config(config_file, environment)
    YAML.load_file(File.join(ROOT_DIR, config_file))[environment]
  end
end
