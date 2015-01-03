require 'rails_helper'
require 'spec_helper'
require 'byebug'

describe Ticket do
  it 'can create an acceptable ticket' do
    build(:villian)
    ticket = Ticket.new
    ticket.submitter =  User.find_by(username: 'villian')
    ticket.title = "title"
    ticket.description = "description"
    expect(ticket).to be_valid
  end

  it 'cannot have a junior support assigned to a supervillian ticket' do
    create(:supervillian)
    create(:juniorsupport)
    ticket = Ticket.new
    ticket.submitter = User.find_by(role: 'supervillian')
    ticket.assigned = User.find_by(role: 'juniorSupport')
    ticket.title = "title"
    ticket.description = "description"
    expect(ticket).to_not be_valid
    expect(ticket.errors[:assigned].size).to eq(1)
  end
end
