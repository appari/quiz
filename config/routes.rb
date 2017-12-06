Rails.application.routes.draw do

  resources :leaderboards
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root :to => 'sessions#login'
    get "/home"  => "sessions#home"
    get "/login" => "sessions#login"
    get "/signup" => "users#new"
    post "/signup" => "users#create"
    post "/login" => "sessions#login_attempt"
    post "/" => "sessions#login_attempt"
    get "/profile"  => "sessions#profile"
    get "/logout" => "sessions#logout"
    get "/add_participant" =>"users#add_participant"
    post "/add_participant" =>"users#create_participant"
    get "/questions_genres" => "questions#genres"
    get "/new_genre" => "genres#new"
    get "/genres" => "genres#index"
    post "/genres" => "genres#create"
    get "/genres/:subgenre" => "questions#quiz" ,as: "genres_subgenre"
    resources :questions
    get "/quiz/index" => "quiz#index"
    post "/quiz/start"
    get "/quiz/question"
    post "/quiz/question"
    post "/quiz/answer" => "quiz#answer"
    get "/quiz/end"
    post "/choices/create"
    post "/choices/destroy"
    get "/quiz/destroy" => "quiz#destroy"
end
