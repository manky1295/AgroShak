class ModeratorsController < ApplicationController
   

	def index
		@offers = Offer.all
	    @carts = Cart.all
	    @vegetables = Vegetable.all
	   
	    @fruits = Fruit.all
	   
	    
	   
	end

	def curr_orders
	    @curr_orders = Order.order('created_at ASC').where(Status: false) 
	    @cartsitems = Cartsitem.all	
	end

	def delivered

	    @delivered_orders = Order.where(Status: true).order('created_at DESC')	
	     @cartsitems = Cartsitem.all	
	end    
def deliverydone
	@order = Order.find(params[:id])
		@order.Status = true
		@order.save
 	respond_to do |format|
    		 format.html { redirect_to '/curr_orders' }
      	format.js {   }
      
    end		
	end
	def deliverynotdone
		@order = Order.find(params[:id])
 		@order.Status = false
 	@order.save
 		respond_to do |format|
   		 format.html { redirect_to '/delivered' }
 	      	format.js {   }
 	      
 	    end
 		
 	end

end
