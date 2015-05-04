class Comment < ActiveRecord::Base
   
   #belongs_to :questions
   
   #Round number, Project_id, Judge_id, question, score
   def self.insert_record (round_number, project_id, judge_id, comment)
       s = Comment.new
       s.round_number = round_number
       s.project_id = project_id
       s.user_id = judge_id
       s.comment = comment
       s.save!
   end
   
   def self.exists?(round_number, project_id, judge_id)
       users = Comment.where(round_number: round_number, project_id: project_id, user_id: judge_id)
       if users.count==0 then
           return false
        else
            return true
       end
   end
   
   def self.update_record(round_number, project_id, judge_id, comment)
       user = Comment.find_by(round_number: round_number, project_id: project_id, user_id: judge_id)
       user.comment = comment
       user.save!
   end
end