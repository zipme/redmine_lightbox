require 'redmine'

require_dependency 'redmine_lightbox/hooks/view_layouts_base_html_head_hook'
require_dependency 'redmine_lightbox/services/document_converter'
require_dependency 'redmine_lightbox/patches/attachment_patch'
require_dependency 'redmine_lightbox/patches/attachments_controller_patch'
require_dependency 'redmine_lightbox/patches/issues_helper_patch'

Redmine::Plugin.register :redmine_lightbox do
  name 'Redmine Light Box plugin'
  author 'G.K.'
  description 'Lightbox for attachments'
  version '0.0.1'
  url 'https://github.com/zipme/redmine_lightbox'
  author_url 'https://github.com/zipme/redmine_lightbox'

  default_settings = {
    'preview_image_attachments' => true
  }

  settings(:default => default_settings, :partial => 'settings/lightbox_settings')
end
