require 'yaml'

module WorkOn

  class Config

    def self.default
      @default ||= Config.new(File.expand_path '~/.config/work_on')
    end

    attr_reader :file_name

    def initialize(file_name)
      self.file_name = file_name
    end

    def file_name=(file_name)
      @file_name = file_name
      @hash = YAML.load_file file_name
    end

    def [](project)
      config = @hash[project]
      raise ArgumentError, "No config found for that project" unless config
      Project.new project, config
    end

  end

end