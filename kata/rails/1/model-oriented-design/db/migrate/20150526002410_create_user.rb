class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
       t.string :role
       t.string :username
    end
  end
end
