class AddImageUrlToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :image_url, :string
  end
end
