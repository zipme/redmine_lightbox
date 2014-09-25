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

  def file_exists?
    diskfile.present? && File.exist?(diskfile)
  end

  def create_preview
    Workers::DocumentConverter.defer(attachment.diskfile, file_type)
  end

  private

  def delete_from_disk!
    File.delete(diskfile) if file_exists?
  end
end
