class CreateAttachmentPreviews < ActiveRecord::Migration
  def up
    create_table :attachment_previews do |t|
      t.references :attachment
      t.string :file_type
    end
  end

  def down
    drop_table :attachment_previews
  end
end
