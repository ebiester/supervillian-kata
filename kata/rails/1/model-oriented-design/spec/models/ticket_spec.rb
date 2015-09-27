require 'rails_helper'

RSpec.describe Ticket, type: :model do
  fixtures :employees, :submitters

  def created_ticket
    ticket = Ticket.new
    ticket.employee = employees(:senior)
    ticket.submitter = submitters(:supervillian)
    ticket.title = "ticket"
    ticket.save!
    ticket
  end

  it "can create a ticket" do
    ticket = Ticket.new
    ticket.title = "title"
    ticket.description = "description"
    ticket.employee = employees(:junior)
    ticket.submitter = submitters(:villian)
    ticket.save!
  end

  it "is by default not started" do
    ticket = Ticket.new
    expect(ticket).to be_not_started
  end

  it "can be started" do
    ticket = created_ticket
    ticket.started!

    expect(Ticket.started.count).to eq(1)
  end

  it "is unassigned if no employee is assigned to the ticket" do
    ticket = Ticket.new
    expect(ticket).to be_unassigned
  end

  it "is not unassigned if an employee is assigned to the ticket" do
    ticket = Ticket.new
    expect(ticket).to be_unassigned
  end

  it "cannot be assigned a junior support employee if the submitter is a supervillian" do
    ticket = Ticket.new
    ticket.employee = employees(:junior)
    ticket.submitter = submitters(:supervillian)

    expect(ticket.valid?).to be false
    expect(ticket.errors[:employee]).to include("Junior support cannot work a supervillian's ticket.")
  end

  it "cannot be assigned an employee if the employee already has a ticket in progress" do
    invalid_ticket = Ticket.new
    invalid_ticket.employee = employees(:senior)
    
    expect(invalid_ticket.employee).to receive(:assigned_ticket).and_return(created_ticket)
    expect(invalid_ticket.valid?).to be false
    expect(invalid_ticket.errors[:employee]).to include("Employee is already assigned a ticket.")
  end

  it "will automatically attempt to be assigned to an employee when created." do
    ticket = Ticket.new
    ticket.submitter = submitters(:villian)
    expect(Employee).to receive(:available_employee).and_return(employees(:junior))
    expect(ticket).to receive(:assign_to_staff).and_call_original
    ticket.save!
    expect(ticket.employee).to be
  end

  it "will not assign a new employee if already assigned" do
    ticket = Ticket.new
    ticket.submitter = submitters(:villian)
    ticket.employee = employees(:junior)
    expect(ticket).not_to receive(:assign_to_staff)
    ticket.save!
  end
end
