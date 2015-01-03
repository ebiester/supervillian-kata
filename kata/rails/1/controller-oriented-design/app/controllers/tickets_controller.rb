class TicketsController < ApplicationController

  def create
    ticket = Ticket.new
    user = User.find_by(username: params[:user])
    ticket.submitter = user
    ticket.title = params[:title]
    ticket.description = params[:description]
    ticket.assigned = get_eligible_support_member_if_available
    ticket.save!
    if ticket.assigned
      user = ticket.assigned
      user.current_ticket = ticket
      user.save!
    end

    render nothing: true
  end

  def get_eligible_support_member_if_available
    User.where("current_ticket_id is ?", nil).take
  end
end
