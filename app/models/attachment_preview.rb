class AttachmentPreview < ActiveRecord::Base
  belongs_to :attachment

  validates :attachment, :presence => true

  before_save :create_preview

  after_destroy :delete_from_disk!

  def filename
    source = attachment.filename  
    RedmineLightbox::Services::DocumentConverter::preview_filename_for(source, file_type)
  end

  def content_type
    Redmine::MimeType.of(filename)
  end

  def diskfile
    source = attachment.diskfile
    RedmineLightbox::Services::DocumentConverter::preview_filename_for(source, file_type)
  end

  private

  def delete_from_disk!
    if diskfile.present? && File.exist?(diskfile)
      File.delete diskfile
    end
  end

  def create_preview
    preview_service = RedmineLightbox::Services::DocumentConverter.new(file_type)
    preview_service.convert(attachment.diskfile)
  end
end
