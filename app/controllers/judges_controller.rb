class JudgesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin
  
  def index
    @contest = Contest.find(params[:contest_id])
    @judges = @contest.users.judges
    @projects = @contest.projects
  end

end
