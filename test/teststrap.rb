require 'riot'
require 'riot/rr'
require 'fakefs/safe'

require 'simplecov'
SimpleCov.start

require 'work-on'

FakeFS do
  # small fakefs hack so Dir.home works
  class Dir
    def self.home
      File.expand_path "~"
    end
  end
  FileUtils.mkdir_p(File.join(Dir.home, ".config", "work-on"))
end

Riot.verbose
