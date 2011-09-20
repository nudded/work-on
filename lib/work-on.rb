module WorkOn
  autoload :Terminal         , 'work_on/terminal.rb'
  autoload :AbstractTerminal , 'work_on/terminal.rb'
  autoload :MacTerminal      , 'work_on/terminals/mac_terminal.rb'
  autoload :Config           , 'work_on/config.rb'
  autoload :YAMLConfig       , 'work_on/config.rb'
  autoload :Project          , 'work_on/project.rb'
  autoload :Cli              , 'work_on/cli.rb'
end
