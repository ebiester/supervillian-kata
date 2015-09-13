class EligibleSupportValidator < ActiveModel::Validator
  def initialize(ticket)
    @ticket = ticket
  end

  def validate
    if junior_support_assigned? && supervillian_ticket?
      @ticket.errors[:employee] << "Junior support cannot work a supervillian's ticket."
    end

    if support_already_has_ticket?
      @ticket.errors[:employee] << "Employee is already assigned a ticket."
    end
  end 

  def junior_support_assigned?
    @ticket.employee && @ticket.employee.junior_support?
  end

  def supervillian_ticket?
    @ticket.submitter && @ticket.submitter.supervillian?
  end

  def support_already_has_ticket?
    assigned_tickets = Ticket.
      where(state: [Ticket.states["not_started"],
                    Ticket.states["started"]],
      employee: @ticket.employee)

    if assigned_tickets.count == 0
      false
    else
      assigned_tickets.first.id != @ticket.id
    end
  end
end

class Ticket < ActiveRecord::Base
  validate do |ticket|
    EligibleSupportValidator.new(ticket).validate
  end

  belongs_to :employee
  belongs_to :submitter

  after_initialize do |ticket|
    ticket.state = :not_started
  end

  enum state: [:not_started,
               :started,
               :finished]
end

