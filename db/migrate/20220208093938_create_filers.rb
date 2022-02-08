class CreateFilers < ActiveRecord::Migration[7.0]
  def change
    create_table :filers do |t|
      t.integer :ein
      t.string :name
      t.text :address
      t.string :city
      t.string :state
      t.integer :zipcode

      t.timestamps
    end
  end
end
