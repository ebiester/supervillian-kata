require 'rails_helper'

describe TicketsController do
  before(:all) do
    @title = 'title'
    @description = 'description'
  end

  def createTicket(submitting_user)
    params = {:user => submitting_user.username, 
              :title => @title,
              :description => @description }

    post 'create', params

    Ticket.find_by(title: @title)
  end

  it "can add a new ticket" do
    villian = create(:villian)
    create(:juniorsupport)

    newticket = createTicket(villian)

    expect(newticket.title).to eq(@title)
    expect(newticket.description).to eq(@description)
    expect(newticket.status).to eq('Open')
    expect(newticket.submitter).to eq(villian)
  end

  it 'will assign an eligible ticket to an open employee' do
    villian = create(:villian)
    create(:juniorsupport)
    newticket = createTicket(villian)

    expect(newticket.assigned).
      to be_an_instance_of(User)
    expect(newticket.assigned.current_ticket).
      to eql(newticket)
  end

  it 'will not assign a ticket to a junior support member if the ticket is from a supervillian' do
    supervillian = create(:supervillian)
    create(:juniorsupport)
    newticket = createTicket(supervillian)

    expect(newticket.assigned).to be_nil
  end

  it 'will assign a ticket to a senior support member if the ticket is from a supervillian' do
    supervillian = create(:supervillian)
    create(:juniorsupport)
    create(:seniorsupport)
    newticket = createTicket(supervillian)

    expect(newticket.assigned.role).
      to eql('seniorSupport')
    expect(newticket.assigned.current_ticket).
      to eql(newticket)
  end

  it 'will update the state of the ticket when updating the ticket' do
    villian = create(:villian)
    create(:juniorsupport)
    IN_PROGRESS_STATUS = 'In Progress'

    newticket = createTicket(villian)

    params = { status: IN_PROGRESS_STATUS,
               id: newticket.id }

    put 'update', params

    updatedticket = Ticket.find_by(title: @title)

    expect(updatedticket.status).to eql(IN_PROGRESS_STATUS)
  end
end
