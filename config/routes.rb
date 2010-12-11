Tracker::Application.routes.draw do


  resources :invitations
  resources :signup
  resources :organizations
  resources :works

#  map.resources :ressources, :has_many => :tasks, :belongs_to => :project

  resources :ressources do
    resources :tasks
  end

#  map.resources :estimations, :has_one => [:task,:estimator]

  resources :estimations  do
    resource :task
    resource :estimator
  end

#  map.resources :baselines, :has_one => [:task,:estimator]

  resources :baselines do
    resource :task
    resource :estimator
  end

#  map.resources :tasks, :has_one => [:project,:ressource], :has_many => [:estimations,:requests, :baselines]
  resources :tasks do
    resource :project
    resources :estimations,:requests, :baselines
  end


#  map.resources :projects, :has_many => [:tasks, :ressources, :reports], :belongs_to => :organization
  resources :projects do
    resources :tasks, :reports, :ressources
  end

  resources :users
  resources :user_sessions
  resources :sparklines


#  map.resources :organizations, :has_many => [:users, :proejcts]
  resources :organizations do
    resources :users, :projects
  end

#  map.resources :estimator, :has_many => :baseline_requests, :controller => "baseline_requests"
# map.resources :estimator, :has_many => :estimation_requests, :controller => "estimation_requests"
  resources :estimator do
    resources :baseline_requests  , :to => "baseline_requests"
    resources :estimation_requests, :to =>  "estimation_requests"
  end

# map.resources :baseline_requests, :has_one => [:estimator]
#  map.resources :estimation_requests, :has_one => [:estimator]

  resources :baseline_requests do
    resource :estimator
  end

  resources :estimation_requests do
    resource :estimator
  end



  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'register/:invitation_token' => 'signup#new', :as => :register
  match 'join' => 'signup#new', :as => :join
  resources :baseline_requests
  resources :estimation_requests
  match '/' => 'user_sessions#new'
  match '/:controller(/:action(/:id))'


end















