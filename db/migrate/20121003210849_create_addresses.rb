class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :f_name
      t.string :l_name
      t.string :phone_num
      t.timestamps
    end
  end
end
