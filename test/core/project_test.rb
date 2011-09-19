context "Project" do
  helper(:config_hash) do
    {'project-dir' => '~/test',
     'tab1' => [],
     'tab2' => []
    }
  end

  setup { WorkOn::Project.new 'test', config_hash }

  hookup do
    terminal = stub(WorkOn::Terminal.instance)
    # new_tab should be called twice
    terminal.selected_window.mock!.new_tab.twice.stub!.execute
    topic.work!
  end

  asserts_topic.assigns(:project_dir, '~/test')

end
