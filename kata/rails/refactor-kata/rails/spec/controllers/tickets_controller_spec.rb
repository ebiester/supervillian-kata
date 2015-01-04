require 'rails_helper'

describe TicketsController do
  before(:all) do
    @title = 'title'
    @description = 'description'
  end

  it "can add a new ticket" do
    villian_user = create(:villian_user)
    create(:junior_support_user)

    params = {:user => villian_user.username, 
              :title => @title,
              :description => @description }

    ticketjson = post 'create', params
    id = JSON.parse(response.body)["id"]
    new_ticket = Ticket.find(id)

    expect(new_ticket.title).to eq(@title)
    expect(new_ticket.description).to eq(@description)
    expect(new_ticket).to be_open
    expect(new_ticket.submitter).to eq(villian_user)
  end
end
