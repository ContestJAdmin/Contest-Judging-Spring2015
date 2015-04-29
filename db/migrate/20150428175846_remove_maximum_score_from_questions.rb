class RemoveMaximumScoreFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :maximum_score, :integer
  end
end
