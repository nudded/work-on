require 'appscript'
module WorkOn

  # Native Mac OS X implementation
  # uses rb-appscript
  class MacTerminal < AbstractTerminal

    include Appscript

    def initialize
      @appscript = app("Terminal.app")
      @process  = app("System Events").application_processes['Terminal']
    end

    def windows
      @appscript.windows.get.map! do |window|
        # it seems this returns far too many windows (some of them don't even exist)
        # so we check a property which will error when something is wrong
        begin
          window.selected.get
          MacWindow.new self, @process, window
        rescue
          nil
        end
      end.compact! # don't forget to remove the nil values
    end

    def new_window
      prev = selected_window
      @process.keystroke('n', :using => :command_down)
      window = selected_window
      prev.select!
      window
    end

    class MacTab < Tab
      def initialize(terminal, appscript)
        @terminal = terminal
        @appscript = appscript
      end

      def selected?
        @appscript.selected.get
      end

      def execute(cmd)
        Appscript.app("Terminal.app").do_script(cmd, :in => @appscript)
      end

    end
    class MacWindow < Window
      def initialize(terminal, process, appscript)
        @terminal = terminal
        @process = process
        @appscript = appscript
      end

      def selected?
        @appscript.frontmost.get
      end

      # Selects this window
      #
      # NOTE:
      # This is not publicly exported since it is only used on the mac Where i
      # need to send keystrokes to the process, so i need to be able to control
      # the currently selected window
      def select!
        @appscript.frontmost.set(true)
      end

      def tabs
        @appscript.tabs.get.map {|tab| MacTab.new @terminal, tab }
      end

      def new_tab
        prev = @terminal.selected_window
        self.select!
        @process.keystroke('t', :using => :command_down)
        prev.select!
        self.tabs.last
      end

      def to_s
        @appscript.id_.get
      end
    end


  end
end
