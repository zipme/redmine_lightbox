require File.expand_path('../../../test_helper', __FILE__)

class RedmineLightbox::AttachmentTest < ActiveSupport::TestCase
  fixtures :users, :projects, :roles, :members, :member_roles,
           :enabled_modules, :issues, :trackers, :attachments

  def setup
    set_tmp_attachments_directory
  end

  if document_converter_available?

    def test_transformed_preview_should_not_generate_the_preview_for_jpg
      attachment = Attachment.find(16)
      attachment.attachment_preview.try(:destroy)
      attachment.attachment_preview = nil
      attachment.save!
      preview = attachment.transformed_preview
      assert_nil preview
    end

    def test_transformed_preview_should_generate_the_preview_for_rtf
      attachment = create_document_attachment
      attachment.attachment_preview.try(:destroy)
      attachment.attachment_preview = nil
      attachment.save!

      preview = attachment.transformed_preview
      assert preview
      assert File.exists?(preview.diskfile)
    end

  else
    puts '(document converter not available)'
  end
end
