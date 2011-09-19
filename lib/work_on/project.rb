module WorkOn

  class Project

    def initialize(name, config)
      @name = name
      @config = config
      @project_dir = @config['project-dir']
      @terminal = Terminal.instance
    end

    # Start working on this project
    def work!
      initialize_windows
    end

    private

    # Sets up the terminal according the config file
    def initialize_windows
      windows = @config.select {|k,v| /window/ === k }
      # if there is no window specified, i will assume the users wants to open the tabs in the current
      # terminal window
      if windows.empty?
        tabs = @config.select {|k,v| /tab/ === k }
        create_tabs(@terminal.selected_window, tabs, false)
      else
        windows.each do |window, tabs_hash|
          create_window(tabs_hash)
        end
      end
    end

    # Create a new window with the commands defined in tabs
    def create_window(tabs)
      window = @terminal.new_window
      create_tabs(window, tabs)
    end

    def create_tabs(window, hash, use_current = true)
      # create as many tabs as needed
      # if use_current is true, create one less and use the current one
      count = hash.keys.size
      if use_current
        count -= 1
        first_tab = window.selected_tab
      end
      tabs = count.times.map { window.new_tab }
      tabs.unshift first_tab if use_current

      hash.values.each.with_index do |commands, i|
        tabs[i].execute "cd #{@project_dir}"
        commands.each do |command|
          tabs[i].execute(command)
        end
      end
    end

  end

end
