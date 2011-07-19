require 'sinatra'
require 'haml'

require_relative 'partials'
require_relative 'helpers'

get '/' do
  haml :index
end

get '/login' do
end

get '/register' do
end

get '/logout' do
end

# confirm_email
# send_confirmation_email

get '/requesters' do
end

get '/recent' do
end

get '/blog' do
end

get '/faq' do
end