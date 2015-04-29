class JudgesController < ApplicationController
     before_filter :authenticate_user!
  def index
       @users = User.all
       @projects = Project.all
  end
  def show
    @judges = User.judges
    @judges_projects = {}
    @judges.each do |judge|
        @judges_projects[judge.id] = Project.includes(:users).where('users.id' => judge.id)
    end
    
    @projects = Project.all
    @projects_judges = {}
    @projects.each do |project|
        @projects_judges[project.id] = User.includes(:projects).where('projects.id' => project.id)
    end
  end
end