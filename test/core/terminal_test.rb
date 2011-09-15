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

context "Window" do
  setup { WorkOn::Terminal.instance }

  setup do
    window1 = topic.new_window
    window1.new_tab
    window2 = topic.new_window
    window2.new_tab
    [window1, window2]
  end

  should("have 2 tabs") { topic.first.tabs }.size(2)
  should("have 2 tabs") { topic.last.tabs }.size(2)


end
