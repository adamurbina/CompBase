class CreateCompsTable < ActiveRecord::Migration
  def change
    create_table :comps do |t|
      t.integer :building_id
      t.integer :user_id
      t.string :date
      t.integer :size
      t.decimal :rent
      t.string :term
    end
  end
end
