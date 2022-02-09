class CreateAwards < ActiveRecord::Migration[7.0]
  def change
    create_table :awards do |t|
      t.float :amount
      t.string :purpose
      t.integer :tax_period
      t.references :filing, null: false, foregin_key: true

      t.timestamps
    end
  end
end
