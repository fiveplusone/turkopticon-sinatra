class Requester < ActiveRecord::Base

  validates_presence_of :amzn_id
  validates_uniqueness_of :amzn_id

  validates_presence_of :amzn_name

  has_many :reviews

  DENOM = "&nbsp;/&nbsp;5"
  EMPTY = "<span class='mono'>no data</span>"

  def comm_text
    comm == 0 ? EMPTY : Requester.vis(comm) + "&nbsp;" + comm.to_s + DENOM
  end
  def fair_text
    fair == 0 ? EMPTY : Requester.vis(fair) + "&nbsp;" + fair.to_s + DENOM
  end
  def fast_text
    fast == 0 ? EMPTY : Requester.vis(fast) + "&nbsp;" + fast.to_s + DENOM
  end
  def pay_text
    pay == 0 ? EMPTY : Requester.vis(pay) + "&nbsp;" + pay.to_s + DENOM
  end

  def comm
    reviews.collect{|r| r.comm}.compact.mean
  end
  def fair
    reviews.collect{|r| r.fair}.compact.mean
  end
  def fast
    reviews.collect{|r| r.fast}.compact.mean
  end
  def pay
    reviews.collect{|r| r.pay}.compact.mean
  end
  def tos_viol_count
    reviews.select{|r| r.tos_viol}.length
  end
  def scammer_count
    reviews.select{|r| r.scammer}.length
  end

  def self.vis(val)
    vmax = 5.0
    chars = 30
    str = "<div class='meter_container'><span class='meter'><span class='meter_full'>"
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
    str.concat("</span></span></div>")
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