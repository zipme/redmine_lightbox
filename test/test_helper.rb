require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

# Stubbed version of converter service
module RedmineLightbox
  module Services
    class DocumentConverter
      CONVERTER = 'echo'

      class << self

        def convert(filename, output_format)
          target_filename = preview_filename_for(filename, output_format)
          if filename.present? && File.exist?(filename) && !File.exists?(target_filename)
            `cp #{filename} #{target_filename}`
          end
        end

        def converter_available?
          true
        end

      end
    end
  end
end

class ActiveSupport::TestCase

  LIGHTBOX_SAMPLES_PATH = begin
    path = File.expand_path(File.dirname(__FILE__) + '/fixtures/files')
    path << '/' unless path.end_with?('/')
    path
  end

  def create_document_attachment
    self.class.fixture_path = LIGHTBOX_SAMPLES_PATH
    filename                = 'test_document.rtf'
    file                    = fixture_file_upload(filename)
    Attachment.create!(
      file:     file,
      author:   User.find(2),
      filename: filename)
  end

end
