module RedmineLightbox
  class Patcher
    class << self
      def apply_controller_patch_to(controller_klass)
        unless controller_klass.included_modules.include?(RedmineLightbox::Patches::ControllerPatch)
          controller_klass.send(:include, RedmineLightbox::Patches::ControllerPatch)
        end
      end
    end
  end
end

require 'redmine_lightbox/hooks/view_layouts_base_html_head_hook'

require 'redmine_lightbox/patches/attachment_patch'

require 'redmine_lightbox/patches/attachments_controller_patch'

require 'redmine_lightbox/patches/application_helper_patch'
require 'redmine_lightbox/patches/issues_helper_patch'

require 'redmine_lightbox/services/document_converter'

# TODO: find the best way to solve dependency hell
RedmineLightbox::Patcher.apply_controller_patch_to(ApplicationController)
RedmineLightbox::Patcher.apply_controller_patch_to(IssuesController)
RedmineLightbox::Patcher.apply_controller_patch_to(WikiController)
RedmineLightbox::Patcher.apply_controller_patch_to(DocumentsController)
RedmineLightbox::Patcher.apply_controller_patch_to(FilesController)
RedmineLightbox::Patcher.apply_controller_patch_to(BoardsController)
