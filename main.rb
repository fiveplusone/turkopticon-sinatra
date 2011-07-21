require 'sinatra'
require 'sinatra/activerecord'
require 'haml'

$LOAD_PATH.unshift('/Users/six/src/turkopticon/helpers')
require 'partials'
require 'helpers'

$LOAD_PATH.unshift('/Users/six/src/turkopticon/models')
require 'person'

$LOAD_PATH.unshift('/Users/six/src/turkopticon/routes')
require 'login'
require 'blog'

enable :sessions

get '/' do
  haml :index
end

get '/requesters' do
  @title = "Requester List"
  haml :requesters
end

get '/reviews' do
end

get '/faq' do
end