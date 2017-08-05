class MembersController < ApplicationController

	def index
		@orders = Order.all.order('created_at ASC')
		@carts = Cart.all
		@cartsitems = Cartsitem.all
		@curr_orders = Order.order('created_at ASC').where(Status: false)
		@delivered_orders = Order.where(Status: true).order('created_at DESC')
	end

	def delivered
		@order = Order.find(params[:id])
		@order.Status = true
		@order.save
		respond_to do |format|
			format.html { redirect_to '/member' }
			format.js{}
		end
	end
	def undelivered
		@order = Order.find(params[:id])
		@order.Status = false 
		@order.save
		respond_to do |format|
			format.html { redirect_to '/member'}
			format.js {}
		end
	end

end
