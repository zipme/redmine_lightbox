require_dependency 'attachments_controller'

module RedmineLightbox
  module Patches
    module AttachmentsControllerPatch
      extend ActiveSupport::Concern

      included do
        unloadable

        before_filter :file_readable, :read_authorize, :only => [:show, :download, :download_inline, :preview, :preview_inline]
      end

      def preview
        send_preview 'attachment'
      end

      def preview_inline
        send_preview 'inline'
      end

      def download_inline
        send_preview 'inline'
      end

      private

      def send_preview(disposition)
        send_file @attachment.diskfile,
                  :filename => filename_for_content_disposition(@attachment.filename),
                  :type => detect_content_type(@attachment),
                  :disposition => disposition
      end
    end
  end
end

unless AttachmentsController.included_modules.include?(RedmineLightbox::Patches::AttachmentsControllerPatch)
  AttachmentsController.send(:include, RedmineLightbox::Patches::AttachmentsControllerPatch)
end
