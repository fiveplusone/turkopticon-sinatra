require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'pony'

$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__))
require 'constants'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'helpers')
require 'partials'
require 'helpers'
require 'before'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'models')
require 'person'
require 'requester'
require 'review'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'mailers')
require 'reg_mailer'

$LOAD_PATH.unshift File.join(File.dirname(File.expand_path(__FILE__)), 'routes')
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
  @requesters = Requester.all
  @title = "Requester List"
  haml :requesters
end

get '/reviews' do
  if session[:notice]
    @notice = session[:notice]
    session[:notice] = nil
  end
  @reviews = Review.all
  @title = "Reviews"
  haml :reviews
end

get '/review' do
  @title = "Review a Requester"
  haml :review
end

get '/faq' do
end