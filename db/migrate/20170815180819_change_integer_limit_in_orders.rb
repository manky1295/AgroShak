class ChangeIntegerLimitInOrders < ActiveRecord::Migration
  def change
  	change_column :orders, :Buyernumber, :integer, limit: 8
  end
end
