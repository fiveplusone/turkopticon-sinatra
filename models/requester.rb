class Requester < ActiveRecord::Base

  validates_presence_of :amzn_id
  validates_uniqueness_of :amzn_id

  validates_presence_of :amzn_name

  has_many :reviews

  def comm
    reviews.collect{|r| r.comm}.mean
  end
  def fair
    reviews.collect{|r| r.fair}.mean
  end
  def fast
    reviews.collect{|r| r.fast}.mean
  end
  def pay
    reviews.collect{|r| r.pay}.mean
  end

  def self.visualize(val)
    vmax = 5.0
    chars = 30
    str = "<span class='meter'><span class='meter_full'>"
    full_fraction = val / vmax
    full_chars = full_fraction * chars
    full_chars = full_chars.round
    full_chars.times do
      str.concat("&nbsp;")
    end
    str.concat("</span><span class='meter_empty'>")
    empty_chars = chars - full_chars
    empty_chars.times do
      str.concat("&nbsp;")
    end
    str.concat("</span></span>")
  end

end

class Array
  def mean
    if self.length == 0
      0
    else
      self.inject{|sum, n| sum + n} / self.length.to_f
    end
  end
end