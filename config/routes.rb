Rails.application.routes.draw do
  post '/' => 'messages#handle'
  get '/list' => 'messages#list'
end
