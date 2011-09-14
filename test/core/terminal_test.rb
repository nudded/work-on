require 'teststrap'

context "Terminal" do
  setup { WorkOn::Terminal.instance }

  asserts_topic.responds_to(:windows)
  asserts_topic.responds_to(:new_window)
  asserts_topic.responds_to(:execute)
  asserts_topic.responds_to(:selected_window)
  asserts_topic.responds_to(:selected_tab)

  asserts("window count increases") do
    topic.windows.size == topic.tap(&:new_window).windows.size - 1
  end

  context "Window" do
    setup { topic.selected_window }
    asserts_topic.responds_to(:new_tab)
    asserts_topic.responds_to(:execute)
  end

  context "Tab" do
    setup { topic.selected_tab }
    asserts_topic.responds_to(:execute)
  end

end
