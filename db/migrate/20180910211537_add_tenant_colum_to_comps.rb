class AddTenantColumToComps < ActiveRecord::Migration
  def change
    add_column :comps, :tenant, :string
  end
end
