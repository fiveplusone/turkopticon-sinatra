PROTECTED_PATHS = ['/requesters', '/reviews']

before do
  path = request.path_info
  if PROTECTED_PATHS.include?(path)
    unless session[:person_id]
      session[:original_path] = path
      session[:error] = 'Please log in to see that.'
      redirect '/login'
    end
  end
end