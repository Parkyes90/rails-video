Rails.application.routes.draw do

  #devise_for :users
  devise_for :users, :controllers => { registrations: 'users/registrations'}

  root 'home#index'
  get 'home/index'
  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'
  get 'privacy_policy', to: 'home#privacy_policy'

  resources :enrollments do
    get :my, on: :collection
  end
  resources :tags, only: [:create, :index, :destroy]

  resources :courses do
    get :learning, :pending_review, :teaching, :unapproved, on: :collection
    member do
      get :analytics
      patch :approve
      patch :unapprove
    end
    resources :lessons, except: [:index] do
      resources :comments, except: [:index]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
    resources :course_wizard, controller: 'courses/course_wizard'
  end

  resources :users, only: [:index, :edit, :show, :update]

  resources :enrollments do
    get :my, on: :collection
    member do
      get :certificate
    end
  end

  namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end
end