class ScoresController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin
  
  def index
    # @scores = Scores.order(:project_id)
    @contest = Contest.find(params[:contest_id])
    @categories = @contest.categories
    @projects = @contest.projects
    @all_judges = @contest.users.judges
    @question_types = @contest.question_types
    @projects_scores = {}
    @judges_scores = {}
    
    # Score per Judge per Project
    # Judge Score is questions averaged for each question type, multiplied by weight, and totaled
    # Final Score is Averaged Judge Scores for a Project
    # Don't display question types, display Judges with Scores for project
    
    @projects.each do |project|
      project_score = 0
      judges = project.users.judges
      num_of_judges_graded = 0
      judges.each do |judge|
        judge_score = 0
        
        @question_types.each do |question_type|
          question_type_score = 0
          question_type.questions.each do |question|
            question_type_score += question.scores.where(:project_id => project.id, :user_id => judge.id).average(:score).to_f
          end
          judge_score += (question_type_score * (question_type.weight/100.0))
        end
        if @judges_scores[judge.id].nil?
          @judges_scores[judge.id] = {}
        end
        @judges_scores[judge.id][project.id] = judge_score
        project_score += judge_score
        num_of_judges_graded += 1 unless judge_score == 0
      end
      @projects_scores[project.id] = project_score/(num_of_judges_graded == 0 ? 1 : num_of_judges_graded)
    end
    
    @projects_scores = @projects_scores.sort_by{|_key, value| value}.reverse.to_h
    
    respond_to do |format|
      format.html
      format.csv { send_data Score.to_csv(@projects_score, @projects) }
    end
  end
end