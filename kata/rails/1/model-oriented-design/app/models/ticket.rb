class EligibleSupportValidator < ActiveModel::Validator
  def initialize(ticket)
    @ticket = ticket
  end

  def validate
    if junior_support_assigned? && supervillian_ticket?
      @ticket.errors[:employee] << "Junior support cannot work a supervillian's ticket."
    end
  end 

  def junior_support_assigned?
    @ticket.employee && @ticket.employee.junior_support?
  end

  def supervillian_ticket?
    @ticket.submitter && @ticket.submitter.supervillian?
  end
end

class Ticket < ActiveRecord::Base
  validate do |ticket|
    EligibleSupportValidator.new(ticket).validate
  end

  belongs_to :employee
  belongs_to :submitter

  after_initialize do |ticket|
    ticket.not_started!
  end

  enum state: [:not_started,
               :started,
               :finished]
end

