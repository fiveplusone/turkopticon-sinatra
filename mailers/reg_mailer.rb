class RegMailer < ActionMailer::Base
  TURKOPTICON = 'turkopticon@differenceengines.com'
  default :from => TURKOPTICON, :bcc => TURKOPTICON

  def verify(person, hash)
    @hash = hash
    mail(:to => person.email, :subject => '[turkopticon] Please verify your email address')
  end

  def password_changed(person, new_password)
    @new_password = new_password
    mail(:to => person.email, :subject => '[turkopticon] Your password was changed')
  end

  def password_reset(person, new_password)
    @new_password = new_password
    mail(:to => person.email, :subject => '[turkopticon] Your password was reset')
  end

end

RegMailer.delivery_method = :sendmail