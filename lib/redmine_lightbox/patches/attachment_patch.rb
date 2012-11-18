require_dependency 'attachment'

module RedmineLightbox
  module Patches
    module AttachmentPatch
      PREVIEW_TRANSFORMATIONS = {
        'doc' => 'pdf',
        'docx' => 'pdf'
      }

      class << self
        def included(base)
          base.class_eval do
            has_one :attachment_preview, :dependent => :destroy

            after_save :generate_preview
          end
        end
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
          attachment_format = filename.rpartition(".")[2]
          preview_format = PREVIEW_TRANSFORMATIONS[attachment_format]
        end

        def generate_preview
          try_to_generate_preview
          true
        end
    end
  end
end

Attachment.send(:include, RedmineLightbox::Patches::AttachmentPatch)
