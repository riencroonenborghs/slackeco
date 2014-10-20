Rails.application.routes.draw do
  post '/' => 'messages#handle'
end
