# Load the normal Rails helper
helper_path = File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')
if !File.exists?(helper_path)
  helper_path = File.expand_path(File.dirname(__FILE__) + '/../../../../test/test_helper')
end

require helper_path
