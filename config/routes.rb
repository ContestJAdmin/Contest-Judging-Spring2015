Rails.application.routes.draw do
  get '/contests/:contest_id/projects/unassigned', to: 'projects#unassigned', :as => :unassigned_projects
  resources :contests do
    resources :categories
    resources :attachments
    resources :projects
    resources :judges
    resources :question_types do 
            resources :questions
    end
  end
  post '/contests/:contest_id/categories/:id/attach', to: 'categories#attach', :as => :attach
  post '/contests/:contest_id/categories/:id/unattach', to: 'categories#unattach', :as => :unattach
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :projects do 
    patch 'assign_judges'
  end
  resources :questions
  resources :question_types
  resources :gradesheets
  resources :scores
end
