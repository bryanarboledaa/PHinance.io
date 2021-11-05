Rails.application.routes.draw do

  root 'static_pages#home_page'
  
  # users
  get '/user_dashboard' => 'users#user_dashboard', as: 'user_dashboard'

  # MainBook
  get '/mainbook' => 'main_books#index'
  get '/mainbook_entries' => 'main_books#mainbook_entries'
  get '/mainbook_entry' => 'main_books#new', as: 'mainbook_new'
  post '/mainbook_entry' => 'main_books#create', as: 'mainbook_entry'
  get '/mainbook/:id/edit' => 'main_books#edit', as: 'edit_mainbook'
  put '/mainbook/:id/edit' => 'main_books#update', as: 'update_mainbook'
  post '/mainbook/:id/delete' => 'main_books#destroy_entry', as: 'delete_entry'

  # export to pdf
  get '/mainbook_export' => 'main_books#export_pdf', as: 'mainbook_export'
  get '/minibook_export' => 'mini_books#export_pdf', as: 'minibook_export'
  get 'mini_books/:mini_book_id/minibook_entries_export' => 'minibook_entries#export_pdf', as: 'minibook_entries_export'

  resources :mini_books do
    resources :minibook_entries
  end

  # Admin
  get 'admins/home' => 'admin_pages#index'
  get 'admins/all_users' => 'admin_pages#all_users'
  get 'admins/paid_users' => 'admin_pages#paid_users'
  get 'admins/free_users' => 'admin_pages#free_users'

  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions" }, only: [:sessions]

  # user
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", registrations: "users/registrations", confirmations: "users/confirmations" }, only: [:sessions, :registrations, :confirmations]
 
  
  # scope '/checkout' do
  #   post 'create', to: 'checkout#create', as: 'checkout_create'
  #   get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  #   get 'success', to: 'checkout#success', as: 'checkout_success'
  # end

  #resources :checkout, only: [:create]
  post "checkouts/create", to: "checkouts#create", as: "checkout_create"

  # Products
  get '/products' => 'abc_products#index'
  get '/product/:id/show' => 'abc_products#show', as: 'abc_product_show'
  # get '/product_new' => 'abc_products#new', as: 'abc_product_new'
  # post '/product_new' => 'abc_products#create', as: 'abc_product_create'
  # get '/product/:id/edit' => 'abc_products#edit', as: 'edit_abc_product'
  # put '/product/:id/edit' => 'abc_products#update', as: 'update_abc_product'
  # post '/product/:id/delete' => 'abc_products#destroy', as: 'delete_abc_product'

  get 'pricing', to: 'static_pages#pricing'
  post "billing_portal/create", to: "billing_portal#create", as: "billing_portal_create"
  resources :webhooks, only: [:create]
end
