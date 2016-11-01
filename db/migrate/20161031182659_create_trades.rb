class CreateTrades < ActiveRecord::Migration[5.0]
  def change
    create_table :trades do |t|
      t.integer :amount
      t.text :url

      t.timestamps
    end
  end
end
