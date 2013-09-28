class AddCategoryListToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :category_id_list, :string
    add_column :checkins, :category_name_list, :string
  end
end
