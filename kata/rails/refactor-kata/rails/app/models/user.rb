class User < ActiveRecord::Base
  belongs_to :current_ticket, class_name: Ticket

  enum role: [:other,
              :junior_support, 
              :senior_support, 
              :villian,
              :supervillian ] 
  
end
