require 'yaml'
require 'abstract'

module WorkOn

  class Config

    def self.default_dir
      File.expand_path '~/.config/work-on/'
    end

    def initialize(project_name)
      file_name = find_file(project_name)
      raise "No config file found" unless file_name
      @config = find_config(file_name)
    end

    def windows
      @config.windows
    end

    def project_dir
      @config.project_dir
    end

    private

    def find_config(file_name)
      case File.extname(file_name)
      when ".rb", ""
        DSLConfig.new(file_name)
      when ".yml", ".yaml"
        YAMLConfig.new(file_name)
      else
        raise "Don't know how to parse #{file_name}"
      end
    end

    def find_file(name)
      base_name = File.join(self.class.default_dir, name)
      files = Dir.glob(base_name + '.*')
      # pick the first one
      files.first
    end

  end

  class ConfigParser

    # windows is an hash which looks like this
    # {:tabs => [['ls -al', 'ls'], ['ls']]}
    # the above hash would open 2 tabs
    #
    # if additional windows need to be opened
    # you can specify the windows key (and provide and array of tab
    #   hashes)
    # {:windows => {[{:tabs => []}, {:tabs =>[]}]}}
    attr_accessor :windows

    # should be set to the complete and expanded path to the project
    attr_reader :project_dir

    def initialize(file_name)
      @windows = {}
      parse(file_name)
    end

    # It does no harm to expand a path multiple times and prevents somebody from forgetting it
    def project_dir=(dir)
      @project_dir = File.expand_path(dir)
    end

    # this method should read and parse the file
    # will be called when initialized
    # implementations should set @windows and @project_dir
    def parse(file_name)
      not_implemented
    end
  end

  class YAMLConfig < ConfigParser
    def parse(file_name)
      hash = YAML.load_file(file_name)
      self.project_dir = hash['project-dir']

      windows = hash.select {|k,v| /window/ === k}
      tabs = hash.select {|k,v| /tab/ === k}
      self.windows[:tabs] = tabs.values
      self.windows[:windows] = windows.values.map {|hash| {:tabs => hash.values}}
    end
  end

end
