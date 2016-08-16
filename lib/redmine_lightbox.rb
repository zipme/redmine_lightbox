module RedmineLightbox
  DEFER_CONVERT = defined?(Resque)
end

ActionDispatch::Callbacks.to_prepare do

  # Patches
  require 'redmine_lightbox/patches/attachment_patch'
  require 'redmine_lightbox/patches/application_controller_patch'
  require 'redmine_lightbox/patches/attachments_controller_patch'

  # Redmine hooks
  require 'redmine_lightbox/hooks/view_hooks'

  # Converter
  require_dependency 'workers/document_converter'
  require_dependency 'redmine_lightbox/services/document_converter'
end
