require 'teststrap'
FakeFS do
  context "Config" do

    asserts "initialize with invalid project" do
      WorkOn::Config.new Random.srand.to_s
    end.raises(RuntimeError)

    setup do
      File.open(File.join(WorkOn::Config.default_dir,"test.yml"), "w") do |f|
        f.write "project-dir: ~/test"
      end
      WorkOn::Config.new 'test'
    end

    asserts(:project_dir).equals(File.join(Dir.home, 'test'))

  end
end
