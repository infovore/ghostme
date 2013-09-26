class AddOriginNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :origin_name, :string
  end
end
