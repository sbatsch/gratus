Rails.application.routes.draw do
  namespace :api do
    get '/journal_entries' => 'journal_entries#index'
    post '/journal_entries' => 'journal_entries#create'
    get '/journal_entries/:id' => 'journal_entries#show'
    patch '/journal_entries/:id' => 'journal_entries#update'
    delete 'journal_entries/:id' => 'journal_entries#destroy'

    post "/users" => "users#create"
    get '/users/:id' => 'users#show'

    post "/sessions" => "sessions#create"


  end
end
