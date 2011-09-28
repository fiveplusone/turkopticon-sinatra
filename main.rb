require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'pony'

$LOAD_PATH.unshift File.dirname(File.expand_path(__FILE__))
require 'dependencies'

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

get '/edit_review/:rid' do
  @title = "Edit Review"
  @review = Review.find(params[:rid])
  req = @review.requester
  params[:name] = req.amzn_name
  params[:id] = req.amzn_id
  params[:hits] = @review.hits
  params[:fair] = @review.fair
  params[:fast] = @review.fast
  params[:pay] = @review.pay
  params[:comm] = @review.comm
  params[:notes] = @review.notes
  params[:update] = true
  LOG.info params.inspect
  haml :review
end

post '/update_review' do
  @review = Review.find(params[:rid])
  params.delete('rid')
  params.delete('name')
  params.delete('id')
  if @review.update_attributes(params)
    session[:notice] = "Review updated."
    redirect '/reviews'
  else
    "Something went wrong. Try going back."
  end
end

post '/review' do
  if params[:name].blank?
    @errors = {}
    @errors[:name] = "Please enter the requester's name."
    @title = "Review a Requester"
    haml :review
  elsif params[:id].blank?
    @errors = {}
    @errors[:id] = "Please enter the requester's ID."
    @title = "Review a Requester"
    haml :review
  else
    req = Requester.find_by_amzn_name_and_amzn_id(params[:name], params[:id])
    if req.nil?
      params[:requester_id] = Requester.create(:amzn_name => params[:name], :amzn_id => params[:id]).id
    else
      params[:requester_id] = req.id
    end
    params.delete('name')
    params.delete('id')
    rev = Review.find_by_requester_id_and_person_id(params[:requester_id], session[:person_id])
    @review = Review.new(params)
    if @review.save
      session[:notice] = "Review saved."
      redirect '/reviews'
    else
      @title = "Review a Requester"
      haml :review
    end
  end
end

get '/faq' do
end