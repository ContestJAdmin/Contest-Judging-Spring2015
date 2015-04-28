class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :projects
  belongs_to :contest
  belongs_to :category
 # has_and_belongs_to_many :projects, :join_table => "projects_users", :foreign_key => "project_id"
end
