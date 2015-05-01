class Score < ActiveRecord::Base
  belongs_to :question
   
  #Round number, Project_id, Judge_id, question, score
  def self.insert_record (round_number, project_id, judge_id, question_id, score, comment)
    s = Score.new
    s.round_number = round_number
    s.project_id = project_id
    s.judge_id = judge_id
    s.question_id = question_id
    s.score = score
    s.comment = comment
    s.save!
  end
   
  def self.update_record(round_number, project_id, judge_id, question_id, score, comment)
    user = Score.find_by(round_number: round_number, project_id: project_id, judge_id: judge_id, question_id: question_id)
    user.score = score
    user.comment = comment
    user.save!
  end

  def Score.to_csv(scores=[], options = {})
    CSV.generate(options) do |csv|
      csv << ['Round Number','Project Name','Username','Question','Score','Comments']
      scores.each do |score|
        csv << [score.round_number,score.project_name,score.user_name,score.question_name,score.score,score.question_comment]
        #score.attributes.values_at(*scores.column_names)
      end
    end
  end

end