class CreateEntries < ActiveRecord::Migration[5.1]
  def change

    create_table :entries do |t|
      t.string :date
      t.string :content
      t.integer :user_id
    end
  end
end
