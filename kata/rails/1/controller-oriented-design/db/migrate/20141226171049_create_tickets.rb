class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.User, :submitter
      t.User, :assigned
      t.string, :title
      t.text :description

      t.timestamps
    end
  end
end
