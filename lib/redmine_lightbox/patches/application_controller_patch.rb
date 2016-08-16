require_dependency 'application_controller'

module RedmineLightbox
  module Patches
    module ApplicationControllerPatch
      extend ActiveSupport::Concern

      included do
        helper_method :attach_lightbox?, :lightbox_gallery_items
      end

      private

      def attach_lightbox?
        %w(issues wiki documents).include?( controller_name ) && lightbox_attachments.any?
      end

      def lightbox_gallery_items
        lightbox_attachments.map { |attachment| generate_gallery_item(attachment) }
      end

      # Attachments for gallery
      def lightbox_attachments
        case controller_name
          when 'issues'
            ( @issue && @issue.attachments ) || []
          when 'wiki'
            ( @page && @page.attachments ) || []
          when 'documents'
            @attachments || []
          else
            []
        end.select { |a| include_in_gallery?(a) }
      end

      def include_in_gallery?(attachment)
        attachment.is_image? ||
          attachment.is_text? && attachment.filesize <= Setting.file_max_size_displayed.to_i.kilobyte ||
          attachment.is_pdf? ||
          attachment.has_pdf_preview?
      end

      def generate_gallery_item(attachment)
        download_url = download_named_attachment_url(attachment.id, attachment.filename)
        case
          when attachment.is_image?
            {
              itemType: 'image',
              src:      download_url,
              matchUrl: download_url,
              subHtml:  [attachment.filename, attachment.description.presence].compact.join(' - ')
            }
          when attachment.is_pdf?
            {
              itemType: 'pdf',
              src:      download_url,
              matchUrl: download_url,
              iframe:   true,
              subHtml:  [attachment.filename, attachment.description.presence].compact.join(' - ')
            }
          when attachment.has_pdf_preview?
            {
              itemType:    'doc',
              src:         url_for(
                             controller: 'attachments',
                             action:     'pdf_preview',
                             id:         attachment,
                             filename:   attachment.filename
                           ),
              matchUrl:    download_url,
              downloadUrl: download_url,
              iframe:      true,
              subHtml:     [attachment.filename, '(PDF preview)', attachment.description.presence].compact.join(' - ')
            }
          when attachment.is_text?
            {
              itemType: 'text',
              src:      url_for(
                          controller: 'attachments',
                          action:     'text_preview',
                          id:         attachment,
                          filename:   attachment.filename
                        ),
              matchUrl: download_url,
              iframe:   true,
              subHtml:  [attachment.filename, attachment.description.presence].compact.join(' - ')
            }
          else
            raise 'No preview available'
        end
      end

    end
  end
end

unless ApplicationController.included_modules.include?(RedmineLightbox::Patches::ApplicationControllerPatch)
  ApplicationController.send(:include, RedmineLightbox::Patches::ApplicationControllerPatch)
end
