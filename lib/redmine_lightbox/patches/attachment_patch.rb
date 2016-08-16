require_dependency 'attachment'

module RedmineLightbox
  module Patches
    module AttachmentPatch
      extend ActiveSupport::Concern

      included do
        PDF_PREVIEW_ALLOWED_FOR = %w(doc docx rtf)

        has_one :pdf_preview, -> { where(file_type: 'pdf') }, class_name: 'AttachmentPreview', dependent: :destroy

        after_save :generate_pdf_preview
      end

      def has_pdf_preview?
        pdf_preview && pdf_preview.file_exists?
      end

      def generate_pdf_preview( force = false )
        return unless convertible_to_pdf?

        return if has_pdf_preview? && !force

        if pdf_preview
          pdf_preview.create_preview
        else
          create_pdf_preview(file_type: 'pdf')
        end
      end

      def convertible_to_pdf?
        PDF_PREVIEW_ALLOWED_FOR.include? filename.rpartition('.')[2].downcase
      end

    end
  end
end

unless Attachment.included_modules.include?(RedmineLightbox::Patches::AttachmentPatch)
  Attachment.send(:include, RedmineLightbox::Patches::AttachmentPatch)
end
