require_dependency 'attachment'

module RedmineLightbox
  module Patches
    module AttachmentPatch
      extend ActiveSupport::Concern

      included do

        PREVIEW_TRANSFORMATIONS = {
          'doc' => 'pdf',
          'docx' => 'pdf',
          'rtf' => 'pdf'
        }

        has_one :attachment_preview, :dependent => :destroy

        after_save :generate_preview
      end


      def try_to_generate_preview
        format = preview_format
        if format && !attachment_preview
          create_attachment_preview(:file_type => format)
        else
          false
        end
      end

      private

      def preview_format
        attachment_format = filename.rpartition(".")[2].downcase
        preview_format = PREVIEW_TRANSFORMATIONS[attachment_format]
      end

      def generate_preview
        try_to_generate_preview
        true
      end
    end
  end
end

unless Attachment.included_modules.include?(RedmineLightbox::Patches::AttachmentPatch)
  Attachment.send(:include, RedmineLightbox::Patches::AttachmentPatch)
end
