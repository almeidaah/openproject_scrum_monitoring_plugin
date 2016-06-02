OpenProject::Application.routes.draw do
  put 'projects/:id' => 'projects#save_project_configs' 
  resources :contexts
  resources :grupos
  resources :counter_repositories
  resources :branches
  resources :group_versions

  get 'contexts/new', :to => 'contexts#new'
  get 'admin/groups/new', :to => 'grupos#new'
  get 'admin/groups/:id/edit', :to => 'grupos#edit'
  delete 'admin/groups/:id', :to => 'grupos#destroy'
  put 'admin/groups/:id', :to => 'grupos#update'
  post 'admin/groups', :to => 'grupos#create'
  post 'branches/append', :to => 'branches#append'
  post 'branches', :to => 'branches#create'
  put 'versions/:id', :to => 'group_versions#update'
end
