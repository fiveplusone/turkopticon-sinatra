class Review < ActiveRecord::Base

  belongs_to :person
  belongs_to :requester
  
end