class AddCurrentTicketToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_ticket_id, :integer
  end
end
