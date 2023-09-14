class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.timestamps
    end
  end
end
