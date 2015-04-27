class CreateQuestionTypes < ActiveRecord::Migration
  def up
    create_table :question_types do |t|
      t.string    'question_type' 
      t.integer   'contest_id'
      t.integer   'weight'
    end
  end
  
  def down
    drop_table :question_types
  end
end
