require 'redmine'

require_dependency 'hooks/view_layouts_base_html_head_hook'

Redmine::Plugin.register :redmine_light_box do
  name 'Redmine Light Box plugin'
  author 'G.K.'
  description 'Lightbox for attachments'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://www.rb2.nl'
end
