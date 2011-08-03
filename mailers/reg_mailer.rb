class RegMail
  def self.verify(person)
    @hash = verification_hash(person.email)
    Sinatra::Templates.haml :verify
  end
  def self.password_changed(new_password)
    @new_password = new_password
    haml :password_changed
  end
  def self.password_reset(new_password)
    @new_password = new_password
    haml :password_reset
  end
  private
  def self.verification_hash(string)
    Digest::SHA1.hexdigest(string + "hi there")
  end
end