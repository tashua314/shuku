class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.date :birthday
      t.string :tel
      t.string :address

      t.timestamps
    end
  end
end
