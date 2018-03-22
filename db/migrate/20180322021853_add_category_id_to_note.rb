class AddCategoryIdToNote < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :category_id, :integer
  end
end
