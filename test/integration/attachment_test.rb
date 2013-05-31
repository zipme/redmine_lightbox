require File.dirname(__FILE__) + '/../test_helper'

class AttachmentTest < ActionController::IntegrationTest
  fixtures :attachments, :users

  def setup
    set_fixtures_attachments_directory

    @some_file = Attachment.find_by_filename("source.rb")

    @some_file.create_attachment_preview(:file_type => "pdf")
  end

  def test_should_get_file
    path = "/attachments/download/#{@some_file.id}/#{@some_file.filename}"
    get_via_redirect(path)
    assert_response :success
  end

  def test_should_get_file_inline
    path = "/attachments/download_inline/#{@some_file.id}/#{@some_file.filename}"
    get_via_redirect(path)
    assert_response :success
  end

  def test_should_get_by_id
    path = "/attachments/#{@some_file.id}/#{@some_file.filename}"
    get_via_redirect(path)
    assert_response :success
  end

  def test_download_button

  end
end
