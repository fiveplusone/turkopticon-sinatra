class Review < ActiveRecord::Base

  belongs_to :person
  belongs_to :requester

  DENOM = "&nbsp;/&nbsp;5"
  EMPTY = "<span class='mono'>no data</span>"

  def comm_text
    if comm == 0 or comm.nil?
      EMPTY
    else
      Requester.vis(comm) + "&nbsp;" + comm.to_s + DENOM
    end
  end

  def fair_text
    if fair == 0 or fair.nil?
      EMPTY
    else
      Requester.vis(fair) + "&nbsp;" + fair.to_s + DENOM
    end
  end

  def fast_text
    if fast == 0 or fast.nil?
      EMPTY
    else
      Requester.vis(fast) + "&nbsp;" + fast.to_s + DENOM
    end
  end

  def pay_text
    if pay == 0 or pay.nil?
      EMPTY
    else
      Requester.vis(pay) + "&nbsp;" + pay.to_s + DENOM
    end
  end
  
end