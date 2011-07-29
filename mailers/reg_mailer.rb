class RegMailer < ActionMailer::Base
  SEND_BCC = true
  FROM = 'turkopticon@differenceengines.com'

  def confirm(person, hash)
    @subject = '[turkopticon] Please confirm your email address'
    @body['hash'] = hash
    @recipients = person.email
    @from = FROM
    @bcc = FROM if SEND_BCC
    @sent_on = Time.now
    @headers = {}
  end

  def password_changed(person, new_password)
    @subject = '[turkopticon] Your password was changed'
    @body['new_password'] = new_password
    @recipients = person.email
    @from = FROM
    @bcc = FROM if SEND_BCC
    @sent_on = Time.now
    @headers = {}
  end

  def password_reset(person, new_password)
    @subject = '[turkopticon] Your password was reset'
    @body['new_password'] = new_password
    @recipients = person.email
    @from = FROM
    @bcc = FROM if SEND_BCC
    @sent_on = Time.now
    @headers = {}
  end

end