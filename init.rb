require 'redmine'

Rails.configuration.to_prepare do
  require 'workers/document_converter'
  require 'redmine_lightbox'
end

Redmine::Plugin.register :redmine_lightbox do
  name 'Redmine Light Box plugin'
  author 'G.K., nodecarter'
  description 'Lightbox for attachments'
  version '0.0.8'
  url 'https://github.com/Undev/redmine_lightbox'

  requires_redmine :version_or_higher => '2.1'
end
