require 'teststrap'
require 'yaml' # otherwise mock fails

context "Config" do
  setup do
    mock(YAML).load_file("test_name") do
      {'test' => {'project-dir' => 'test-dir'}}
    end
    WorkOn::Config.new("test_name")
  end

  denies(:[], 'test').nil
  asserts_topic.assigns(:file_name)

  context "with small test project" do
    setup { topic['test'] }
    asserts_topic.assigns(:project_dir, 'test-dir')
  end
end
