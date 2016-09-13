Rails.application.routes.draw do
  get '/' => 'meetings#index'

  get '/meetings' => 'meetings#index'
  get '/meetings/new' => 'meetings#new'
  get '/meetings/:id' => 'meetings#show'
  post '/meetings' => 'meetings#create'
  get '/meetings/:id/edit' => 'meetings#edit'
  patch '/meetings/:id' => 'meetings#update'

  namespace :api do
    namespace :v1 do
      get '/meetings' => 'meetings#index'
      post '/meetings' => 'meetings#create'
      get '/tags' => 'tags#index'
    end
  end
end
