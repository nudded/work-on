require 'thor'

module WorkOn
  class Cli < Thor

    desc "start PROJECT", "start working on the given project"
    def start(project_name)
      Project.new(Config.new(project_name)).work!
    end

    # use method_missing to start the project
    def method_missing(name, *args)
      start(name.to_s)
    end
  end
end
