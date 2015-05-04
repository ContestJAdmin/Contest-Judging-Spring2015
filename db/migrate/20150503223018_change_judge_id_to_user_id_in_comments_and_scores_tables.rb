class ChangeJudgeIdToUserIdInCommentsAndScoresTables < ActiveRecord::Migration
  def change
    rename_column :scores, :judge_id, :user_id
    rename_column :comments, :judge_id, :user_id
  end
end
