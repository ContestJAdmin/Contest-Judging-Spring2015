Rails.application.routes.draw do
    resources :contests do
        resources :categories
        resources :attachments
        resources :projects
        resources :question_types
    end
    post '/contests/:contest_id/categories/:id/attach', to: 'categories#attach', :as => :attach
    post '/contests/:contest_id/categories/:id/unattach', to: 'categories#unattach', :as => :unattach
    root to: 'visitors#index'
    devise_for :users
    resources :users
    resources :projects
    resources :judges
    resources :questions
    resources :gradesheets
    resources :scores
end
