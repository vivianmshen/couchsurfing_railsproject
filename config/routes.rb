Friendswap::Application.routes.draw do
  get "listings/index" 
  #get "listings/index" => "listings#index"
  get "listings/create"
  get "listings/delete"
  get "listings/edit"
  post "listings/update"
  get "user/edit"
  get "user/delete"
  post "user/update"
  post "listings/post_create"

  match "/auth/:provider/callback", :to => "sessions#create", via: [:get, :post]
  match "/auth/failure", :to => redirect('/'), via: [:get, :post]
  match "signout", to: "sessions#destroy", as: 'signout', via: [:get, :post]

  get "user/login"

  get "listings/newyork"
  get "listings/sanfrancisco"
  get 'listings/user/:id' => 'listings#user'
  get 'listings/listing/:id' => 'listings#listing'
  get 'listings/listing/:id/review' => 'listings#review'
  
  get "listings/:city" => "listings#city"
  get "listings/:city/:id" => "listings#category"

  post "listings/post_photo" 
  post "listings/post_review" 

  get "user/dashboard" => "user#dashboard"
  get "user/dashboard/profile" => "user#profile"
  get "user/dashboard/inbox" => "user#inbox"
  get "user/dashboard/listings" => "user#listings"

  #get "listings/newyork/:id/city=:city" => "listings#category"
  #get "listings/sanfrancisco/:id/city=:city" => "listings#category"
  #get 'listings/newyork/:id' => 'listings#newyork#category'
  #get 'listings/sanfrancisco/:id' => 'listings#sanfrancisco#category'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  #match ':controller(/:action(/:id))(.:format)'
end
