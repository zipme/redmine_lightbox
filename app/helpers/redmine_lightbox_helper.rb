module RedmineLightboxHelper

  def link_to_attachment_with_preview(attachment, options = {})
    #TODO: remove this shit after the best way will be found
    self.class.send(:include, RedmineLightboxHelper) unless self.methods.include?(:preview_available?)

    original_link = link_to_attachment_without_preview(attachment, options)

    return original_link unless preview_available?(attachment)

    preview_icon = absolute_asset_url('images/preview.png')
    icon_style = 'width: 18px; margin: 0px 4px'
    preview_button = image_tag(preview_icon, :style => icon_style)

    raw("#{original_link} #{preview_link_with(attachment, preview_button)}")
  end

  def thumbnail_with_preview_tag(attachment)
    preview_link_with(attachment,
                      image_tag(url_for(:controller => 'attachments', :action => 'thumbnail', :id => attachment)))
  end

  def absolute_asset_url(asset_url, plugin_asset = true)
    if plugin_asset
      paths = [
          'plugin_assets',
          'redmine_lightbox',
          asset_url
      ]
      relative_url = File.join(*paths)
    else
      relative_url = asset_url
    end

    "#{home_url}#{relative_url}"
  end

  def preview_available?(attachment)
    image = attachment.image?
    pdf_or_swf = attachment.filename =~ /.(pdf|swf)$/i
    attachment_preview = attachment.transformed_preview
    text = attachment.is_text?

    image || text || pdf_or_swf || attachment_preview
  end

  def preview_link_with(attachment, preview_button)
    if attachment.transformed_preview
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

    unless attachment.is_text?
      link_to(preview_button, {
          :controller => 'attachments',
          :action => attachment_action,
          :id => attachment,
          :filename => attachment.filename,
          :only_path => false },
              :class => link_class,
              :rel => 'attachments',
              :title => attachment_title
      )
    end
  end

end
