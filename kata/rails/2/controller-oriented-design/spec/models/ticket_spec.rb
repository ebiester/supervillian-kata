require 'rails_helper'
require 'spec_helper'
require 'byebug'

describe Ticket do
  it 'can create an acceptable ticket' do
    villian_user = build(:villian_user)
    ticket = Ticket.new
    ticket.submitter = villian_user
    ticket.title = "title"
    ticket.description = "description"
    expect(ticket).to be_valid
  end

  it 'cannot have a junior support assigned to a supervillian ticket' do
    supervillian_user = create(:supervillian_user)
    junior_support_user = create(:junior_support_user)
    ticket = Ticket.new
    ticket.submitter = supervillian_user
    ticket.assigned = junior_support_user
    ticket.title = "title"
    ticket.description = "description"
    expect(ticket).to_not be_valid
    expect(ticket.errors[:assigned].size).to eq(1)
  end
end
