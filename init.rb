Redmine::Plugin.register :redmine_lightbox do
  name 'Redmine Light Box plugin'
  author 'Restream'
  description 'Lightbox for attachments'
  version '2.0.0'
  url 'https://github.com/Restream/redmine_lightbox'

  requires_redmine version_or_higher: '2.6'
end

require 'redmine_lightbox'
