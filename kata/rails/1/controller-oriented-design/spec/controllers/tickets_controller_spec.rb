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

    ticketjson = post 'create', params

    id = JSON.parse(response.body)["id"]
    Ticket.find(id)
  end

  it "can add a new ticket" do
    villian = create(:villian)
    create(:juniorsupport)

    new_ticket = createTicket(villian)

    expect(new_ticket.title).to eq(@title)
    expect(new_ticket.description).to eq(@description)
    expect(new_ticket).to be_open
    expect(new_ticket.submitter).to eq(villian)
  end

  it 'will assign an eligible ticket to an open employee' do
    villian = create(:villian)
    create(:juniorsupport)
    new_ticket = createTicket(villian)

    expect(new_ticket.assigned).
      to be_an_instance_of(User)
    expect(new_ticket.assigned.current_ticket).
      to eql(new_ticket)
  end

  it 'will not assign a ticket to a junior support member if the ticket is from a supervillian' do
    supervillian = create(:supervillian)
    create(:juniorsupport)
    new_ticket = createTicket(supervillian)

    expect(new_ticket.assigned).to be_nil
  end

  it 'will assign a ticket to a senior support member if the ticket is from a supervillian' do
    supervillian = create(:supervillian)
    create(:juniorsupport)
    create(:seniorsupport)
    new_ticket = createTicket(supervillian)

    expect(new_ticket.assigned.role).
      to eql('seniorSupport')
    expect(new_ticket.assigned.current_ticket).
      to eql(new_ticket)
  end

  it 'will update the state of the ticket when updating the ticket' do
    villian = create(:villian)
    create(:juniorsupport)

    new_ticket = createTicket(villian)

    params = { status: :active,
               id: new_ticket.id }

    put 'update', params

    updatedticket = Ticket.find_by(title: @title)

    expect(updatedticket).to be_active
  end

  it 'will clear the assigned support member\'s current ticket if the ticket is being closed and there is no next ticket' do
    villian = create(:villian)
    create(:juniorsupport)
    new_ticket = createTicket(villian)
    params = { status: :closed,
               id: new_ticket.id }

    put 'update', params

    updatedticket = Ticket.find_by(title: @title)
    expect(updatedticket.assigned.current_ticket).to be_nil
  end

    it 'will assign the next ticket if there is an eligible ticket' do
    villian = create(:villian)
    juniorsupport = create(:juniorsupport)
    to_be_closed_ticket = createTicket(villian)
    next_ticket = createTicket(villian)
    params = { status: :closed,
               id: to_be_closed_ticket.id }

    put 'update', params

    next_ticket.reload
    juniorsupport.reload
    expect(next_ticket.assigned).to eql(juniorsupport)
    expect(juniorsupport.current_ticket).to eql(next_ticket)
  end
end
