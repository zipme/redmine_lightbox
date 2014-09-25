require 'attachment'

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
        return if preview_format.nil? || has_transformed_preview?
        if attachment_preview
          attachment_preview.create_preview
        else
          create_attachment_preview(:file_type => preview_format)
        end
      end

      def transformed_preview
        try_to_generate_preview
        attachment_preview
      end

      def has_transformed_preview?
        attachment_preview && attachment_preview.file_exists?
      end

      private

      def preview_format
        @preview_format ||= PREVIEW_TRANSFORMATIONS[filename.rpartition(".")[2].downcase]
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
