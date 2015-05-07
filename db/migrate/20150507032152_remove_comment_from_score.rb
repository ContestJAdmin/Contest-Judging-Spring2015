class RemoveCommentFromScore < ActiveRecord::Migration
  def change
    remove_column :scores, :comment
  end
end
