class CreateFilings < ActiveRecord::Migration[7.0]
  def change
    create_table :filings do |t|
      t.references :filer, null: false, foreign_key: true
      t.float :amount
      t.string :purpose
      t.integer :tax_period
      t.references :recipient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
