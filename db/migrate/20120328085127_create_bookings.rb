class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :room, :null => false
      t.string :who
      t.date :date
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
