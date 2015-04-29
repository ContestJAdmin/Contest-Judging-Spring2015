class GradesheetsController < ApplicationController
    #@global_project_id = nil
    
    def show
        @comment = 
        @project = Project.find(params[:id])
        @question_types = @project.contest.question_types
        params.merge(:global_project_id => params[:id])
        #@global_project_id = @project
        #@judge_id  = 1
    end
    
    def update
        flash[:notice] = "Gradesheet submitted!"
        @questions = Question.all
        @questions.each do |q|
            #Round number, Project_id, Judge_id, question, score
            if Score.exists?(1, params[:id], current_user.id, q) then
                Score.update_record(1, params[:id], current_user.id, q, params[q.id.to_s]['score'], params["comment"+q.id.to_s].strip)
            else 
                Score.insert_record(1, params[:id], current_user.id, q, params[q.id.to_s]['score'], params["comment"+q.id.to_s].strip)
            end
        end
        # if Comment.exists?(1, params[:id], current_user.id) then
        #     Comment.update_record(1, params[:id], current_user.id, params["comment"])
        # else
        #     Comment.insert_record(1, params[:id], current_user.id, params["comment"])
        # end
        redirect_to :projects
    end
end