require 'yaml'

context "Project" do
  helper(:config) do
    mock(YAML).load_file('test.yml') do
      {'project-dir' => '~/test',
       'tab1' => [],
       'tab2' => []
      }
    end
    WorkOn::YAMLConfig.new('test.yml')
  end

  setup { WorkOn::Project.new config }

  hookup do
    terminal = stub(WorkOn::Terminal.instance)
    # new_tab should be called twice
    terminal.selected_window.mock!.new_tab.twice.stub!.execute
    topic.work!
  end

  asserts(:project_dir).equals(Dir.home + '/test')

end
