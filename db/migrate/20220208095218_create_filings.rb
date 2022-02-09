class CreateFilings < ActiveRecord::Migration[7.0]
  def change
    create_table :filings do |t|
      t.references :filer, null: false, foreign_key: true
      t.references :recipient, null: false, foregin_key: true

      t.timestamps
    end
  end
end
