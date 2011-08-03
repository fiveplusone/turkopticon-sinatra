class RegMail

  VERIFY_TEXT = "Thanks for registering with Turkopticon. To help fight bogus reviews, please verify your email address by visiting:\n\n" + TURKOPTICON + "verify_email/"
  PASSWORD_TEXT = "Somebody, hopefully you, has changed your password at turkopticon.differencesengines.com. Your new password is\n\n"
  PASSWORD_AFTER_TEXT = "\n\nand you can log in at\n\n" + TURKOPTICON + "login"

  def self.verify(person)
    VERIFY_TEXT + verification_hash(person.email) + "\n\nThanks!"
  end
  def self.password_changed(new_password)
    PASSWORD_TEXT + new_password + PASSWORD_AFTER_TEXT
  end
  def self.password_reset(new_password)
    PASSWORD_TEXT.gsub('changed', 'reset') + new_password + PASSWORD_AFTER_TEXT
  end

  private
  def self.verification_hash(string)
    Digest::SHA1.hexdigest(string + "hi there")
  end
end