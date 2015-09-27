class Employee < ActiveRecord::Base
  has_many :tickets

  enum role: [:junior_support, 
              :senior_support] 

  def self.available_employee
    true
  end

  def assigned_ticket
    assigned_tickets = Ticket.
    where(state: [Ticket.states["not_started"],
                  Ticket.states["started"]],
          employee: self)

    assigned_tickets ? assigned_tickets.first : nil
  end
end
