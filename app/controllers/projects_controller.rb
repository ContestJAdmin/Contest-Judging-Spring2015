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
    @projects = current_user.projects
  end

  def new
    @project = @contest.projects.build
  end

  def show
    if current_user.admin? then 
      @project = Project.find(params[:id])
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