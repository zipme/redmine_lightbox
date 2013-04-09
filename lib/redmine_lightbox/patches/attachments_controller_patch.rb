require_dependency 'attachments_controller'

module RedmineLightbox
  module Patches
    module AttachmentsControllerPatch
      extend ActiveSupport::Concern

      included do
        before_filter :file_readable, :read_authorize, :only => [:show, :download, :download_inline]

        helper :redmine_lightbox
      end

      def download_inline
        send_file @attachment.diskfile, :filename => filename_for_content_disposition(@attachment.filename),
                                        :type => detect_content_type(@attachment),
                                        :disposition => 'inline'
      end

    end
  end
end

unless AttachmentsController.included_modules.include?(RedmineLightbox::Patches::AttachmentsControllerPatch)
  AttachmentsController.send(:include, RedmineLightbox::Patches::AttachmentsControllerPatch)
end
