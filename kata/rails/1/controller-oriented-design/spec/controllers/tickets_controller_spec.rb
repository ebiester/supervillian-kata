require 'rails_helper'

describe TicketsController do
  context 'two user fixture' do
    it "can add a new ticket" do
      create(:villian)
      create(:juniorsupport)
      
      villian = User.find_by(username: 'villianUser')
      title = 'title'
      description = 'description'
      
      params = {:user => villian.username, 
                :title => title,
                :description => description }

      post 'create', params

      newticket = Ticket.find_by(title: title)
      expect(newticket.title).to eq(title)
      expect(newticket.description).to eq(description)
      expect(newticket.submitter).to eq(villian)
    end

    it 'will assign an eligible ticket to an open employee' do
      create(:villian)
      create(:juniorsupport)

      villian = User.find_by(username: 'villianUser')
      title = 'title'
      description = 'description'

      params = {:user => villian.username, 
                :title => title,
                :description => description }

      post 'create', params

      newticket = Ticket.find_by(title: title)
      expect(newticket.assigned).to be_an_instance_of(User)
      expect(newticket.assigned.current_ticket).to eql(newticket)
    end

  end

  context 'no user fixture' do
    it 'will not assign a ticket to a junior staff if the ticket is from a supervillian' do
      create(:villian)
      create(:juniorsupport)

      expect(User.count).to eql(2)
    end

  end


end
