class Project < ActiveRecord::Base
  validates :location, uniqueness: true
  
  def location_unique?
    Project.where(:location => self.location, :contest_id => self.contest_id).count == 0
  end
  
  belongs_to :category
  belongs_to :contest
  
  has_and_belongs_to_many :users
  has_many :scores, :dependent => :destroy
 #   has_and_belongs_to_many :users, :join_table => "projects_users", :foreign_key => "user_id"
end