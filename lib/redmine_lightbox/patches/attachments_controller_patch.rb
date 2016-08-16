require_dependency 'attachments_controller'

module RedmineLightbox
  module Patches
    module AttachmentsControllerPatch
      extend ActiveSupport::Concern

      included do
        before_action :check_attachment_available, only: [:text_preview, :pdf_preview]
      end

      def text_preview
        if @attachment.is_text? && @attachment.filesize <= Setting.file_max_size_displayed.to_i.kilobyte
          @content = File.read(@attachment.diskfile, mode: 'rb')
          render action: 'file', layout: 'content_only'
        else
          render :nothing
        end
      end

      def pdf_preview
        preview = @attachment.pdf_preview
        send_file preview.diskfile,
          filename:    filename_for_content_disposition(preview.filename),
          type:        'application/pdf',
          disposition: 'inline'
      end

      private

      def check_attachment_available
        false if find_attachment == false || file_readable == false || read_authorize == false
      end

    end
  end
end

unless AttachmentsController.included_modules.include?(RedmineLightbox::Patches::AttachmentsControllerPatch)
  AttachmentsController.send(:include, RedmineLightbox::Patches::AttachmentsControllerPatch)
end
