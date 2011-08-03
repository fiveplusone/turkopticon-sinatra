class Requester < ActiveRecord::Base

  validates_presence_of :amzn_id
  validates_uniqueness_of :amzn_id

  validates_presence_of :amzn_name

  has_many :reviews

end