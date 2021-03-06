class User < ActiveRecord::Base
  belongs_to :current_ticket, class_name: Ticket

  ::MAX_TICKETS = { :junior_support => 1,
                    :senior_support => 2 }

  enum role: [:other,
              :junior_support, 
              :senior_support, 
              :villian,
              :supervillian ] 
  
end
