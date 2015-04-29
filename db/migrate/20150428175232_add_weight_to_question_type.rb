class AddWeightToQuestionType < ActiveRecord::Migration
  def change
    add_column :question_types, :weight, :integer
  end
end
