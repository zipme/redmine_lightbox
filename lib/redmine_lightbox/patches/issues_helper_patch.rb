require_dependency 'issues_helper'

module RedmineLightbox
  module Patches
    module IssuesHelperPatch

      def link_to_attachment_with_preview(attachment, options = {})
        preview_button = image_tag('preview.png', :plugin => :redmine_lightbox, :class => "preview_button")

        download_link = link_to_attachment_without_preview(attachment)

        if attachment.image? && Setting.plugin_redmine_lightbox['preview_image_attachments']
          download_link
        else
          "#{download_link} #{preview_link_with(attachment, preview_button)}"
        end
      end

      def show_detail_with_only_path_disabled(detail, no_html = false, options={})
        show_detail_without_only_path_disabled(detail, no_html, options.merge(:only_path => false))
      end

      private
        def preview_link_with(attachment, preview_button)
          if attachment.attachment_preview
            link_class = "attachment_preview"
            attachment_action = "preview"
          else
            if attachment.filename =~ /.(pdf|swf)$/i
              link_class = $1
            else
              link_class = "image"
            end
            attachment_action = ($1 === 'swf' || attachment.image?) ? 'download_inline' : 'show'
          end

          if attachment.description.present?
            attachment_title = "#{attachment.filename}#{ ('-' + attachment.description)}"
          else
            attachment_title = attachment.filename
          end

          if attachment.is_text?
            link_to(image_tag('magnifier.png'),
              :controller => 'attachments', 
              :action => 'show',
              :id => attachment,
              :filename => attachment.filename)
          else
            link_to(preview_button, {
              :controller => 'attachments',
              :action => attachment_action,
              :id => attachment,
              :filename => attachment.filename },
              :class => link_class,
              :rel => 'attachments',
              :title => attachment_title
            )
          end
        end

      class << self
        def included(klass)
          klass.class_eval do
            alias_method_chain :link_to_attachment, :preview
            alias_method_chain :show_detail, :only_path_disabled
          end
        end
      end
    end
  end
end

IssuesHelper.send(:include, RedmineLightbox::Patches::IssuesHelperPatch)
