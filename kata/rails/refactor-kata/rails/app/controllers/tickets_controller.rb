class TicketsController < ApplicationController

  def create
    ticket = Ticket.new
    ticket.submitter = User.find_by(username: params[:user])
    ticket.title = params[:title]
    ticket.description = params[:description]
    roles = []
    ticket.assigned = User.where("current_ticket_id is ? and role IN (?)", 
               nil, ticket.submitter.supervillian? ? roles << User.roles[:senior_support] : 
               [User.roles[:junior_support], User.roles[:senior_support]] ).first

    ticket.open!
    ticket.save!
    if ticket.assigned
      user = ticket.assigned
      user.current_ticket = ticket
      user.save!
    end

    render :json => ticket
  end
  
  def update
    ticket = Ticket.find(params[:id])
    ticket.status = params[:status]
    ticket.save!

    if ticket.closed?
      assigned_user = ticket.assigned
      roles = []
      next_ticket = Ticket.joins(:submitter).
        where("assigned_id is ? and users.role in (?) ", 
              nil,  assigned_user.junior_support? ? 
              roles << User.roles[:villian] :
              [User.roles[:villian], User.roles[:supervillian]]).first
        assigned_user.current_ticket = next_ticket
      assigned_user.save!
      if next_ticket
        next_ticket.assigned = assigned_user
        next_ticket.save!
      end
    end

    render nothing: true
  end
end
