class AddWeightToCartsitem < ActiveRecord::Migration
  def change
    add_column :cartsitems, :weight, :integer
  end
end
