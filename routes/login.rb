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
    RegMailer.confirm(@person, confirmation_hash(@person.email)).deliver
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
  @title = "Forgot Password"
  haml :forgot_password
end

post '/reset_password' do
  if params[:email]
    person = Person.find_by_email(params[:email])
  elsif params[:name]
    person = Person.find_by_name(params[:name])
  else
    @error = 'Please enter an email address or username.'
    @title = 'Forgot Password'
    haml :forgot_password
  end
  if person.nil?
    field = params[:email].nil? ? 'username' : 'email address'
    @error = "Sorry, couldn't find user with that " + field + "."
    @title = 'Forgot Password'
    haml :forgot_password
  elsif person
    new_password = person.object_id.to_s + Time.now.strftime("%s")
    new_password.gsub!(/0/, 'a').gsub!(/1/, '_')
    person.update_attribute('password', new_password)
    RegMailer.password_reset(person, new_password).deliver
    session[:notice] = "Your password was reset. Your new password was emailed to #{person.email}."
  end
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
    RegMailer.password_changed(person, new_password).deliver
    redirect '/requesters'
  else
    @error = "Something unexpected happened. If you have a minute, please email us."
    @title = "Change Password"
    haml :change_password
  end
end

get '/settings' do
end