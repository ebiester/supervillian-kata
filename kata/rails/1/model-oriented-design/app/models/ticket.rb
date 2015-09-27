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
    if @ticket.employee
      assigned_ticket = @ticket.employee.assigned_ticket
      assigned_ticket && assigned_ticket != @ticket
    else
      false
    end
  end
end

class Ticket < ActiveRecord::Base
  validate do |ticket|
    EligibleSupportValidator.new(ticket).validate
  end

  before_save :assign_to_staff, if: :unassigned?

  belongs_to :employee
  belongs_to :submitter

  after_initialize do |ticket|
    ticket.state = :not_started
  end

  enum state: [:not_started,
               :started,
               :finished]

  def unassigned? 
    employee == nil
  end

  def assign_to_staff
    self.employee = Employee.available_employee
  end
end

