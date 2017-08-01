class MembersController < ApplicationController

	def index
		@orders = Order.all.order('created_at ASC')
		@carts = Cart.all
		@cartsitems = Cartsitem.all
		@curr_orders = Order.order('created_at ASC').where(Status: false)
		@delivered_orders = Order.where(Status: true).order('created_at DESC')
	end

end
