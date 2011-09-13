require 'abstract'
require 'singleton'

module WorkOn

  # Base class for Terminals
  # only tabs allow for command execution
  # So the idea is that you only call execute on a tab
  #
  # This means that every window should have at least 1 tab (even though it will not be visible gui-wise)
  class AbstractTerminal

    include Singleton

    # Base class for windows of a terminal
    class Window

      # should return an Array of Tab objects
      def tabs
        not_implemented
      end

      # Create a new Tab and return the reference to it
      def new_tab
        not_implemented
      end

      # is this window currently selected?
      def selected?
        not_implemented
      end

      # returns the selected tab in this window
      # NOTE: it is better to overwrite Terminal#selected_tab if you need the speed boost
      def selected_tab
        tabs.find {|tab| tab.selected? }
      end

    end

    # Base class for tabs, this is the class that should implement an #execute method
    class Tab

      def selected?
        not_implemented
      end

      def selected=(bool)
        not_implemented
      end

      def execute(cmd)
        not_implemented
      end

    end

    def new_window
      not_implemented
    end

    def windows
      not_implemented
    end

    # it is possible to overwrite this method if you feel the speed boost is necessary
    def selected_window
      windows.find {|w| w.selected?}
    end

    # it is possible to overwrite this method if you feel the speed boost is necessary
    def selected_tab
      selected_window.selected_tab
    end

    ########################################
    # Below here, no more abstract methods #
    ########################################

    class Window

      # executes @cmd in the selected tab
      def execute(cmd)
        selected_tab.execute(cmd)
      end

    end

    def execute(cmd)
      selected_window.execute(cmd)
    end

  end

  # Interface to the outside world
  # Terminal.new will check the current platform and return a AbstractTerminal subclass based on it
  class Terminal

    def self.instance
      case RUBY_PLATFORM
      when /darwin/
        MacTerminal.instance
      else
        raise "no implementation found for your platform"
      end
    end

  end

end
