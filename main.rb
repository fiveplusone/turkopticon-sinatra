require 'sinatra'
require 'sinatra/activerecord'
require 'haml'

$LOAD_PATH.unshift('/Users/six/src/turkopticon')
require 'constants'

$LOAD_PATH.unshift('/Users/six/src/turkopticon/helpers')
require 'partials'
require 'helpers'
require 'before'

$LOAD_PATH.unshift('/Users/six/src/turkopticon/models')
require 'person'
require 'requester'
require 'review'

$LOAD_PATH.unshift('/Users/six/src/turkopticon/mailers')
require 'reg_mailer'

$LOAD_PATH.unshift('/Users/six/src/turkopticon/routes')
require 'login'
require 'blog'

enable :sessions
LOG = Logger.new(STDOUT)

get '/' do
  haml :index
end

get '/requesters' do
  if session[:notice]
    @notice = session[:notice]
    session[:notice] = nil
  end
  @title = "Requester List"
  haml :requesters
end

get '/reviews' do
  @title = "Reviews"
  haml :reviews
end

get '/faq' do
end