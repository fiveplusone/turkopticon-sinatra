class Person < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  validates_presence_of :password
  validates_confirmation_of :password

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = Person.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(name, password)
    person = self.find_by_name(name)
    if person
      expected_password = encrypted_password(password, person.salt)
      if person.hashed_password != expected_password
        person = nil
      end
    end
    person
  end

  private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "foobar" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end