class User < ActiveRecord::Base
  belongs_to :current_ticket, class_name: Ticket
end
