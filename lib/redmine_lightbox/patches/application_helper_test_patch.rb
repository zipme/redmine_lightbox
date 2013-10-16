class ApplicationHelperTest < ActionView::TestCase

  def self.method_added(method_name)
    if method_name == :test_link_to_attachment
      self.send :undef_method, method_name
      self.send :define_method, :test_link_to_attachment__replacement do
        a = Attachment.find(3)
        preview_link = '<a href="http://test.host/attachments/download_inline/3/logo.gif" class="image" rel="attachments" title="logo.gif-This is a logo"><img alt="Preview" src="http://test.host/plugin_assets/redmine_lightbox/images/preview.png" style="width: 18px; margin: 0px 4px" /></a>'
        assert_equal '<a href="/attachments/3/logo.gif">logo.gif</a>' + preview_link,
                    link_to_attachment(a)
        assert_equal '<a href="/attachments/3/logo.gif">Text</a>' + preview_link,
                    link_to_attachment(a, :text => 'Text')
        assert_equal '<a href="/attachments/3/logo.gif" class="foo">logo.gif</a>' + preview_link,
                    link_to_attachment(a, :class => 'foo')
        assert_equal '<a href="/attachments/download/3/logo.gif">logo.gif</a>' + preview_link,
                    link_to_attachment(a, :download => true)
        assert_equal '<a href="http://test.host/attachments/3/logo.gif">logo.gif</a>' + preview_link,
                    link_to_attachment(a, :only_path => false)
      end
    end
  end

end
