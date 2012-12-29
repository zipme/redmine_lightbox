class CreateAttachmentPreviews < ActiveRecord::Migration
  def up
    self.class.up
  end

  def down
    self.class.down
  end

  def self.up
    create_table :attachment_previews do |t|
      t.references :attachment
      t.string :file_type
    end
  end

  def self.down
    drop_table :attachment_previews
  end
end
