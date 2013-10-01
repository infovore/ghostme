class AddSecondaryAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secondary_access_token, :string
  end
end
