class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.column :filename, :string
      t.column :content_type, :string
      t.column :data, :binary
      t.timestamps
    end
  end
  
  def down
      drop_table :attachments
  end
end
