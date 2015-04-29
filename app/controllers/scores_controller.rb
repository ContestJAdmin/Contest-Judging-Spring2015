class ScoresController < ApplicationController
  before_filter :authenticate_user!
  def index
    # @scores = Scores.order(:project_id)
    @contest = Contest.find(params[:contest_id])
    @projects = @contest.projects;
    @question_types = @contest.question_types;
    @projects_scores = {}
    @projects_question_type_scores = {}
    
    @projects.each do |project|
      project_score = 0
      question_type_score = {}
      @question_types.each do |question_type|
        question_type.questions.each do |question|
          puts question.scores.where(:project_id => project.id).inspect
          question_type_score[question_type.id] = question.scores.where(:project_id => project.id).average(:score).to_f
        end
        question_type_score[question_type.id] ||= 0
        project_score += (question_type_score[question_type.id] * (question_type.weight/100.0))
      end
      @projects_question_type_scores[project.id] = question_type_score
      @projects_scores[project.id] = project_score
    end
    
    @projects_scores = @projects_scores.sort_by{|_key, value| value}.reverse.to_h
    
    puts @projects_scores
    puts @projects_question_type_scores
    
    @scores = Score.joins(' s  inner join users u on s.judge_id=u.id inner join projects p on s.project_id=p.id inner join questions q on s.question_id=q.id;').select('s.round_number,p.name as project_name,u.name as user_name,q.question as question_name,s.score, s.comment as question_comment' )
    respond_to do |format|
      format.html
      format.csv { send_data Score.to_csv(@scores) }
      format.xls 
    end
  end
end