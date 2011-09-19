module WorkOn
  class Cli
    def self.start(*args)
      first = args.shift
      case first
      when 'init'
        # initialize with demo config file
      else other
        Config.default[first].work!
      end
    end
  end
end
