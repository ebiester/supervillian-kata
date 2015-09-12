class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :submitter
      t.references :employee
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
