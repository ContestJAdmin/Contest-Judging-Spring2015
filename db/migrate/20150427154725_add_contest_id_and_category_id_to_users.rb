class AddContestIdAndCategoryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contest_id, :integer
    add_column :users, :category_id, :integer
  end
end
