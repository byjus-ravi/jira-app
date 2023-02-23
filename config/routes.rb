Rails.application.routes.draw do
  root "epics#index"
  get '/search',to:"epics#search",as:"epics_search"
  get '/changecomment/:id/:num',to:"subtasks#show",as:"change_comment"
  get 'subtask/byuser',to:"subtasks#byuser",as:"subtask_byuser"
  get 'subtask/touser',to:"subtasks#touser",as:"subtask_touser"
  get 'stories/new/:epic',to:"stories#new",as:"stories_new"
  get 'subtasks/new/:story',to:"subtasks#new",as:"subtasks_new"
  get 'comments/new/:subtask',to:"comments#new",as:"comments_new"
  resources :epics ,except: [:destroy]
  resources :stories , except: [:new]
  resources :subtasks, except: [:new]
  resources :comments, only: [:create, :destroy]
  devise_for :users
end
