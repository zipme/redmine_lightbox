require 'redmine_lightbox/patches/application_helper_patch'
require 'redmine_lightbox/patches/issues_helper_patch'

require 'redmine_lightbox/hooks/view_layouts_base_html_head_hook'
require 'redmine_lightbox/patches/attachment_patch'
require 'redmine_lightbox/patches/attachments_controller_patch'
require 'redmine_lightbox/patches/documents_helper_patch'
require 'redmine_lightbox/services/document_converter'

if Rails.env == 'test'
  # This plugin change redmine functionality so tests should be changed too
  require 'redmine_lightbox/patches/application_helper_test_patch.rb'
end
