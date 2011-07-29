get '/login' do
  @title = "Login"
  haml :login
end

post '/login' do
  person = Person.authenticate(params[:name], params[:password])
  if person
    session[:person_id] = person.id
    redirect '/requesters'
  else
    @error = "Sorry, that username/password combination isn't in our database."
    @title = "Login"
    haml :login
  end
end

get '/register' do
  @title = "Register"
  haml :register
end

post '/register' do
  @person = Person.new(params)
  if @person.save
    # todo: deliver email
    session[:person_id] = @person.id
    redirect '/requesters'
  else
    @title = "Register"
    haml :register
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# confirm_email
# send_confirmation_email

get '/forgot_password' do
end

get '/change_password' do
  @title = "Change Password"
  haml :change_password
end

post '/change_password' do
  person = Person.find(session[:person_id])
  if params[:password].blank?
    @error = "Password can't be blank."
    @title = "Change Password"
    haml :change_password
  elsif params[:password] != params[:password_confirmation]
    @error = "Password must match confirmation."
    @title = "Change Password"
    haml :change_password
  elsif person.update_attribute('password', params[:password])
    session[:notice] = "Password changed."
    redirect '/requesters'
  else
    @error = "Something unexpected happened. If you have a minute, please email us."
    @title = "Change Password"
    haml :change_password
  end
end

get '/settings' do
end