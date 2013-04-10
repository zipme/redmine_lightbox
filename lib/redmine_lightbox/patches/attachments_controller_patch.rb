require 'attachments_controller'

module RedmineLightbox
  module Patches
    module AttachmentsControllerPatch
      extend ActiveSupport::Concern

      included do
        before_filter :file_readable, :read_authorize, :only => [:show, :download, :download_inline, :preview, :preview_inline]
      end

      def preview
        send_preview 'attachment'
      end

      def preview_inline
        send_preview 'inline'
      end

      def download_inline
        send_file @attachment.diskfile, :filename => filename_for_content_disposition(@attachment.filename),
                                        :type => detect_content_type(@attachment),
                                        :disposition => 'inline'
      end

      private

      def send_preview(disposition)
        preview = @attachment.attachment_preview
        send_file preview.diskfile, :filename => filename_for_content_disposition(preview.filename),
                  :type => detect_content_type(preview),
                  :disposition => disposition
      end
    end
  end
end

unless AttachmentsController.included_modules.include?(RedmineLightbox::Patches::AttachmentsControllerPatch)
  AttachmentsController.send(:include, RedmineLightbox::Patches::AttachmentsControllerPatch)
end
