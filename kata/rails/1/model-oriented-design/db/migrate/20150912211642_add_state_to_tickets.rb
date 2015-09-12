class AddStateToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :state, :integer
  end
end
