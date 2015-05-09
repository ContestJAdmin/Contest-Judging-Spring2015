class Project < ActiveRecord::Base
  validates_uniqueness_of :location, :scope => :contest_id
  
  def location_unique?
    return Project.where(:contest_id => self.contest_id).where(:location => self.location).count == 0
  end
  
  belongs_to :category
  belongs_to :contest
  
  has_many :comments
  has_and_belongs_to_many :users
  has_many :scores, :dependent => :destroy
 #   has_and_belongs_to_many :users, :join_table => "projects_users", :foreign_key => "user_id"
end