class AddWeightinToCartsitem < ActiveRecord::Migration
  def change
    add_column :cartsitems, :weightin, :string
  end
end
