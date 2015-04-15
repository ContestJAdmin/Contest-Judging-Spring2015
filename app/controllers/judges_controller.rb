class JudgesController < ApplicationController
     before_filter :authenticate_user!
  def index
       @users = User.all
       @projects = Project.all
  end
  def show
    @tests = User.joins(:projects).select('users.name as user_name, users.email, projects.name as project_name, projects.location, count(projects.id) as total_proj')
    @jps = User.joins('u left outer join projects_users pj on pj.user_id=u.id').select('u.name as user_name, u.email, count(pj.project_id) as total_proj' ).where('u.id <> 1').group('pj.user_id,u.name,u.email')
    @pjs = Project.joins('p left outer join projects_users pj on pj.project_id=p.id').select('p.name as proj_name, count(pj.user_id) as total_judge' ).group('pj.project_id,p.name')
  end
end