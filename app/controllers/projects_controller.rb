class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :has_contest, :only => [:new, :create, :destroy, :unassigned]

  protected
  def has_contest
    unless (@contest = Contest.find(params[:contest_id]))
      flash[:error] = 'Project must be for an existing contest'
      redirect_to contests_path
    end
  end    
  
  public
  def index
    
    contest = current_user.contest
    projects = current_user.projects
    question_types = contest.question_types
    @graded_projects = {}
    @ungraded_projects = []
    @projects_scores = {}
    projects.each do |project|
      project_score = 0
      question_type_score = 0
      question_types.each do |question_type|
        question_type.questions.each do |question|
          question_type_score = question.scores.where(:project_id => project.id).average(:score).to_f
        end
        question_type_score ||= 0
        project_score += (question_type_score * (question_type.weight/100.0))
      end
      if project_score == 0
        @ungraded_projects.push(project)
      else
        @projects_scores[project.id] = project_score
        @graded_projects[project.id] = project
      end
    end
    
    @projects_scores = @projects_scores.sort_by{|_key, value| value}.reverse.to_h
    
  end

  def new
    @project = @contest.projects.build
  end

  def show
    if current_user.admin? then 
      @project = Project.find(params[:id])
      @users = @project.category ? @project.category.users : []
    end
    # unless @user == current_user || current_user.admin?
    #   redirect_to :back, :alert => "Access denied."
    # end
    if !current_user.admin? then
      redirect_to :gradesheet
    end   
  end

  def create
    @project = @contest.projects.build(project_params)
    puts project_params
    if @project.save
      flash[:success] = "Successfull"
      redirect_to @contest
    else
      render 'new'
    end
  end

  def self.get_project_details(id)
    return Project.find(id)
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project Updated"
      redirect_to :back
    else
      render 'projects/edit'
    end
  end
  
  def assign_judges
    params[:project] ||= {}
    params[:project][:user_ids] ||= []
    @project = Project.find(params[:project_id])
    if @project.update_attributes(params[:project].permit!)
      flash[:notice] = 'Update successful'
      redirect_to contest_project_path(@project.contest, @project)
    else
      render :action=>'show'
    end
  end
  
  def unassigned
    @projects = @contest.projects.where("category_id IS NULL")
    render 'projects/unassigned'
  end
  
  def destroy
    @project = @contest.projects.find(params[:id])
    @project.destroy
    redirect_to contest_path(@contest)
  end

  private

  def project_params
    params.require(:project).permit(:name, :location, :category_id)
  end
end