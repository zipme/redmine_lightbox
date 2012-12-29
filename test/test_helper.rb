# Load the normal Rails helper
helper_path = File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

plugin_root = File.expand_path(File.dirname(__FILE__) + '/../')

if RUBY_VERSION >= "1.9"
  require 'simplecov'
  SimpleCov.start do
    base_dir = plugin_root
    root base_dir
    add_group "Models", "app/models"
    add_group "Controllers", "app/controllers"
    add_group "Helpers", "app/helpers"
    add_group "Views", "app/views"
    add_group "Lib", "lib"
  end
end

require helper_path
