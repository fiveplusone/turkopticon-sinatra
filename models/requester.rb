class Requester < ActiveRecord::Base

  validates_presence_of :amzn_id
  validates_uniqueness_of :amzn_id

  validates_presence_of :amzn_name

  has_many :reviews

  def comm
    2.5
  end
  def fair
    2.5
  end
  def fast
    2.5
  end
  def pay
    2.5
  end

end