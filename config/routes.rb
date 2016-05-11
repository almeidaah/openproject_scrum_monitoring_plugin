OpenProject::Application.routes.draw do
  put 'projects/:id' => 'projects#save_project_configs' 
  resources :contexts
  resources :grupos
  resources :counter_repositories
  resources :branches

  get 'contexts/new', :to => 'contexts#new'
  get 'admin/groups/new', :to => 'grupos#new'
  get 'admin/groups/:id/edit', :to => 'grupos#edit'
  put 'admin/groups/:id', :to => 'grupos#update'
  post 'admin/groups', :to => 'grupos#create'
  post 'branches/append', :to => 'branches#append'
  post 'branches', :to => 'branches#create'

end
