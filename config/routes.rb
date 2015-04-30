Rails.application.routes.draw do

  resources :dashboard, :only => [:index]

  namespace :housing do
    resources :listings do
      collection do
        get '/index/:city/:province/:country', to: 'listings#index'
      end
    end
  end

  #Favorites
  namespace :dashboard do
    resources :profile
    namespace :housing do
      resources :favorites
      resources :alerts
      resources :listings do
        get 'new', to: 'listings#new'
      end
    end
  end

  namespace :api, :defaults => { :format => :json } do
    namespace :v1 do
      resources :cloudinary_images
      namespace :housing do
        resources :favorites, :only => [:create, :destroy]
        resources :users
        resources :alerts
        resources :listings do
          collection do
            get 'near'
            get 'compare_nearby_listings_price'
            get 'num_alerts'
            get 'rating'
            get 'favorites'
            get 'reviews'
            get 'images'
            get 'amenities'
            post 'send_inquiry_email'
            post 'comment'
            post 'housing_with_filters'
          end
        end
      end
    end
  end

  devise_for :users, :controllers => { :registrations => :registrations }

  devise_scope :user do 
    # get "/dashboard/profile", to: "devise/registrations#edit"
  end

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
