class Score < ActiveRecord::Base
  belongs_to :question
   
  #Round number, Project_id, Judge_id, question, score
  def self.insert_record (round_number, project_id, judge_id, question_id, score)
    s = Score.new
    s.round_number = round_number
    s.project_id = project_id
    s.user_id = judge_id
    s.question_id = question_id
    s.score = score
    s.save!
  end
   
  def self.update_record(round_number, project_id, judge_id, question_id, score)
    user = Score.find_by(round_number: round_number, project_id: project_id, user_id: judge_id, question_id: question_id)
    user.score = score
    user.save!
  end

  def Score.to_csv(projects_scores=[], projects=[], options={})
    CSV.generate(options) do |csv|
      csv << ['Project Name','Project Category','Score']
      projects_scores.each do |project_id, score|
        project = projects.find(project_id)
        csv << [project.name, project.category.name, score]
      end
    end
  end

end