class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :submitter_id
      t.string :assigned_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
