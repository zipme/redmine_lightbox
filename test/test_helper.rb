require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

class ActiveSupport::TestCase

  LIGHTBOX_SAMPLES_PATH = begin
    path = File.expand_path(File.dirname(__FILE__) + '/fixtures/files')
    path << '/' unless path.end_with?('/')
    path
  end

  def self.document_converter_available?
    RedmineLightbox::Services::DocumentConverter.converter_available?
  end

  def create_document_attachment
    self.class.fixture_path = LIGHTBOX_SAMPLES_PATH
    filename = 'test_document.rtf'
    file = fixture_file_upload(filename)
    Attachment.create!(
        :file => file,
        :author => User.find(2),
        :filename => filename)
  end

end
