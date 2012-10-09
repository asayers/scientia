Scientia::Application.routes.draw do
  root to: "home#index"
  
  get     "home"              => "home#index"
  get     "tutorial"          => "home#tutorial",     as: "tutorial"
  get     "status"            => "home#status",       as: "status"
  post    "log_in"            => "sessions#create",   as: "log_in"
  get     "log_out"           => "sessions#destroy",  as: "log_out"
  get     "sign_up"           => "users#new",         as: "sign_up"
  post    "sign_up"           => "users#create",      as: "users"
  get     "new_document"      => "documents#new",     as: "new_user_document"
  post    "new_document"      => "documents#create",  as: "user_documents"
  get     "new_template"      => "templates#new",     as: "new_user_template"
  post    "new_template"      => "templates#create",  as: "user_templates"
  get     "new_bibliography"  => "bibliographies#new",     as: "new_user_bibliography"
  post    "new_bibliography"  => "bibliographies#create",  as: "user_bibliographies"
  get     ":id"               => "users#show",        as: "user"
  put     ":id"               => "users#update"
  delete  ":id"               => "users#destroy"
  get     ":id/edit"          => "users#edit",        as: "edit_user"
  get     ":user_id/:id"      => "documents#show",    as: "user_document"
  put     ":user_id/:id"      => "documents#update"
  delete  ":user_id/:id"      => "documents#destroy"
  get     ":user_id/:id/edit" => "documents#edit",    as: "edit_user_document"
  get     ":user_id/templates/:id"    => "templates#show",    as: "user_template"
  put     ":user_id/templates/:id"    => "templates#update"
  delete  ":user_id/templates/:id"    => "templates#destroy"
  get   ":user_id/templates/:id/edit" => "templates#edit",    as: "edit_user_template"
  get     ":user_id/bibliographies/:id" => "bibliographies#show",    as: "user_bibliography"
  put     ":user_id/bibliographies/:id"    => "bibliographies#update"
  delete  ":user_id/bibliographies/:id"    => "bibliographies#destroy"
  get ":user_id/bibliographies/:id/edit" => "bibliographies#edit", as: "edit_user_bibliography"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
