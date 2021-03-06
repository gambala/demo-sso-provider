DemoTemplateRails::Application.routes.draw do

  root to: 'accounts#index'

  # Client side
  get '/auth' => 'authentications#auth'
  get '/logout', to: 'authentications#logout'
  match '/auth/:provider/callback', to: 'authentications#callback'
  match '/auth/failure', to: 'authentications#failure'
  match '/auth/detach', to: 'authentications#detach'

  match '/account', to: 'accounts#index'
  match '/account/edit', to: 'accounts#edit'
  match '/account/update', to: 'accounts#update'

  # Provider side
  resources :applications

  match '/authorize', to: 'orders#register'
  get '/orders/:id' => 'orders#show', as: :order
  get '/orders/:id/accept' => 'orders#accept', as: :order_accept
  get '/orders/:id/deny' => 'orders#deny', as: :order_deny

  get '/grants/:id' => 'grants#show', as: :grant
  match '/grants/:id' => 'grants#destroy', as: :grant, via: :delete
  match '/oauth/token' => 'grants#token'
  match "/get_info", to: "accounts#get_info"


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

  # You can have the root of your site routed with 'root'
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with 'rake routes'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
