get '/login' do
  if session[:error]
    @error = session[:error]
    session[:error] = nil
  end
  @title = "Login"
  haml :login
end

post '/login' do
  person = Person.authenticate(params[:name], params[:password])
  if person
    session[:person_id] = person.id
    if session[:original_path]
      path = session[:original_path]
      session[:original_path] = nil
      redirect path
    else
      redirect '/requesters'
    end
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
    Pony.mail(:to => @person.email,
              :from => TURKOPTICON_EMAIL,
	      :subject => '[turkopticon] Please verify your email address',
	      :body => RegMail.verify(@person))
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

get '/email_verification' do
  @title = 'Email Verification'
  haml :email_verification
end

get '/send_verification_email' do
  person = Person.find(session[:person_id])
  Pony.mail(:to => person.email,
            :from => TURKOPTICON_EMAIL,
	    :subject => '[turkopticon] Please verify your email address',
	    :body => RegMail.verify(person))
  LOG.info "sent mail:\n" + mail.to_s
  @title = 'Email Verification'
  @notice = "We've emailed #{person.email}. Please click the link in the email to verify your address."
  haml :email_verification
end

get '/verify_email/:hash' do
  for person in Person.all
    if verification_hash(person.email) == params[:hash] and person.update_attribute('email_verified', true)
      session[:person_id] = person.id
      session[:notice] = 'Thank you for verifying your email address.'
      redirect '/requesters'
    end
  end
  @title = 'Email Verification'
  haml :verify_email
end

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
    Pony.mail(:to => person.email,
              :from => TURKOPTICON_EMAIL,
	      :subject => '[turkopticon] Your password was reset',
	      :body => RegMail.password_reset(@person))
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
    Pony.mail(:to => person.email,
              :from => TURKOPTICON_EMAIL,
	      :subject => '[turkopticon] Your password was changed',
	      :body => RegMail.password_changed(@person))
    redirect '/requesters'
  else
    @error = "Something unexpected happened. If you have a minute, please email us."
    @title = "Change Password"
    haml :change_password
  end
end

get '/settings' do
end