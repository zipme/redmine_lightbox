require 'redmine'

Rails.configuration.to_prepare do
  require 'redmine_lightbox'
end

Redmine::Plugin.register :redmine_lightbox do
  name 'Redmine Light Box plugin'
  author 'G.K., Undev'
  description 'Lightbox for attachments'
  version '0.0.3'
  url 'https://github.com/Undev/redmine_lightbox'
  author_url 'https://github.com/Undev'

  requires_redmine :version_or_higher => '2.1'
end
