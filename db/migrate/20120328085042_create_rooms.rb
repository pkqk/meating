class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name, :null => false
      t.string :param, :null => false

      t.timestamps
    end
  end
end
