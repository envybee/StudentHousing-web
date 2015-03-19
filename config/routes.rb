Rails.application.routes.draw do

  get 'housing_listing/show'

  get 'housing_listing/edit/:id', to: 'housing_listing#edit', as: 'edit_housing_listing'

  get 'housing_listing/new/:id', to: 'housing_listing#new', as: 'new_housing_listing'

  get 'housing_listing/show/:city/:province/:country', to: 'housing_listing#show', as: 'housing_results'

  post 'api_cloudinary_image/new', as: 'api_cloudinary_image_new'

  # get 'housing_listing/near' => 'api_housing_listing#near'
  get 'api/v1/housing_listings/near' => 'api_housing_listing#near'

  get 'api/v1/housing_listings/index' => 'api_housing_listing#index'
  
  get 'api/v1/housing_settings/index' => 'api_housing_setting#index'
  
  get 'api/v1/users/index' => 'api_user#index'

  post 'api_housing_listing/new', as: 'api_new_housing_listing'

  post 'api_housing_listing/create', as: 'api_create_housing_listing'

  post 'api_housing_listing/update', as: 'api_update_housing_listing'
  
  post 'api_housing_listing/delete', as: 'api_delete_housing_listing'

  post 'api_housing_listing/housing_with_filters', as: 'api_filter_housing_listing'

  get 'dashboard/index', as: 'dashboard_index'

  devise_for :users
  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

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
end
