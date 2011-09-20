require 'teststrap'
require 'yaml' # otherwise mock fails

context "YAMLConfig" do
  helper(:basic_config) do
    {"project-dir"=>"~/Projects/work-on", "window1"=>{"tab1"=>["rails server"], "tab2"=>["rails console"], "tab3"=>["git status", "mvim"]}}
  end
  setup do
    mock(YAML).load_file("test_name.yml") { basic_config }
    WorkOn::YAMLConfig.new("test_name.yml")
  end

  asserts(:project_dir).equals(Dir.home + "/Projects/work-on")

  context "windows hash" do
    setup { topic.windows[:windows] }
    asserts(:first).equals({:tabs => [['rails server'], ['rails console'], ['git status', 'mvim']]})
  end

  context 'with multiple windows' do
    helper(:complex_config) do
      {"project-dir"=>"~/Projects/work-on",
        "window1"=>{"tab1"=>["rails server"], "tab2"=>["rails console"], "tab3"=>["git status", "mvim"]},
        "window2"=>{"tab1"=>["rails server"], "tab2"=>["rails console"], "tab3"=>["git status", "mvim"]},
        "tab1"=>["rails server"], "tab2"=>["rails console"], "tab3"=>["git status", "mvim"]
      }
    end
    setup do
      mock(YAML).load_file("test_name.yml") { complex_config }
      WorkOn::YAMLConfig.new("test_name.yml")
    end

    asserts(:project_dir).equals(Dir.home + "/Projects/work-on")

    context "window hash" do
      setup { topic.windows[:windows] }

      asserts(:first).equals({:tabs => [['rails server'], ['rails console'], ['git status', 'mvim']]})
      asserts("both windows have the same config") { topic.first == topic.last }

    end

    context "tab hash" do
      setup { topic.windows[:tabs] }

      asserts_topic.equals([['rails server'], ['rails console'], ['git status', 'mvim']])
    end

  end
end
