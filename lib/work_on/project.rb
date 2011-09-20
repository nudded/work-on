module WorkOn

  class Project

    def initialize(config)
      @config = config
      @terminal = Terminal.instance
    end

    def project_dir
      @config.project_dir
    end

    # Start working on this project
    def work!
      initialize_windows
    end

    private

    # Sets up the terminal according the config file
    def initialize_windows
      # first create the tabs
      tabs = @config.windows[:tabs]
      create_tabs(@terminal.selected_window, tabs, false)

      # then the windows
      @config.windows[:windows].each do |tabs_hash|
        create_window(tabs_hash[:tabs])
      end
    end

    # Create a new window with the commands defined in tabs
    def create_window(tabs)
      window = @terminal.new_window
      create_tabs(window, tabs)
    end

    def create_tabs(window, array, use_current = true)
      # create as many tabs as needed
      # if use_current is true, create one less and use the current one
      count = array.size
      if use_current
        count -= 1
        first_tab = window.selected_tab
      end
      tabs = count.times.map { window.new_tab }
      tabs.unshift first_tab if use_current

      array.each.with_index do |commands, i|
        tabs[i].execute "cd #{project_dir}"
        commands.each do |command|
          tabs[i].execute(command)
        end
      end
    end

  end

end
