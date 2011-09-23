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

post '/review' do
  req = Requester.find_by_amzn_name_and_amzn_id(params[:name], params[:id])
  if req.nil?
    params[:requester_id] = Requester.create(:amzn_name => params[:name], :amzn_id => params[:id]).id
  else
    params[:requester_id] = req.id
  end
  params.delete('name')
  params.delete('id')
  @review = Review.new(params)
  if @review.save
    session[:notice] = "Review saved."
    redirect '/reviews'
  else
    @title = "Review a Requester"
    haml :review
  end
end

get '/faq' do
end