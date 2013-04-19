require 'redmine'

require 'redmine_lightbox/hooks/view_layouts_base_html_head_hook'
require 'redmine_lightbox/services/document_converter'
require 'redmine_lightbox/patches/attachment_patch'
require 'redmine_lightbox/patches/attachments_controller_patch'
require 'redmine_lightbox/patches/application_helper_patch'
require 'redmine_lightbox/patches/issues_helper_patch'
require 'redmine_lightbox/patches/wiki_helper_patch'
require 'redmine_lightbox/patches/documents_helper_patch'

Redmine::Plugin.register :redmine_lightbox do
  name 'Redmine Light Box plugin'
  author 'G.K., Undev.ru'
  description 'Lightbox for attachments'
  version '0.0.2'
  url 'https://github.com/Undev/redmine_lightbox'
  author_url 'https://github.com/Undev/redmine_lightbox'
end
