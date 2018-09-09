class CreateBuildingsTable < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :address
      t.string :city_state
    end
  end
end
