OpenProject::Application.routes.draw do
  put 'projects/:id' => 'projects#save_project_configs' 
  resources :contexts
  resources :grupos
  resources :counter_repositories
  resources :branches

  get 'contexts/new', :to => 'contexts#new'
  get 'admin/groups/new', :to => 'grupos#new'
  post 'admin/groups', :to => 'grupos#create'
end
