class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  before_filter :initialize_cart
   
  # GET /homes
  # GET /homes.json
  def index
    @homes = Home.all
    @offers = Offer.all
    @carts = Cart.all
    @vegetables = Vegetable.all
    @combos = Combo.all
    @fruits = Fruit.all
    @cartsitems = Cartsitem.where(cart_id: @cart.id)
  end

  def checkout
    
    @carts = Cart.all
    @cartsitems = Cartsitem.where(cart_id: @cart.id)
    @order = Order.new
    @user = User.find(current_user.id)
    if @user.cartnumber
      @user.cartnumber = @user.cartnumber + 1
      
    else
      @user.cartnumber = 1
    end
    @user.save

  end

  def ordernow
    validate :Buyername ,presence: true 
    byebug
    @order = Order.new(order_params)
    @order.cart_id = @cart.id
    @order.user_id = current_user.id
    @order.status = false
  end

  def userprofile
    @user = User.find(current_user.id)
    @orders = Order.where(user_id: current_user.id).order('created_at ASC')
    @carts = Cart.where(user_id: current_user.id)
    @cartsitems = Cartsitem.all 
    @curr_orders = Order.order('created_at ASC').where(user_id: current_user.id).where(Status: false)
    @delivered_orders = Order.where(user_id: current_user.id).where(Status: true).order('created_at DESC')
  end

  def vegetable
    @vegetables = Vegetable.all
    @carts = Cart.all
    @cartsitems = Cartsitem.where(cart_id: @cart.id)

  end

  def fruit
    @fruits = Fruit.all
    @carts = Cart.all
    @cartsitems = Cartsitem.where(cart_id: @cart.id)
  end

  def offer
    @offers = Offer.all
    @carts = Cart.all
    @vegetables = Vegetable.all
    @fruits = Fruit.all
    @cartsitems = Cartsitem.where(cart_id: @cart.id)
  end
  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


   before_action :authenticate_user! ,only: [:addfruit , :addvegetable]


  def removeFruit
    @item = Fruit.find(params[:fruit_id])
    if @cartsitem = Cartsitem.all.find_by(cart_id: @cart.id , fruit_id: @item.id)
      session[:cartsitem_id] = @cartsitem.id
    end
    if @cartsitem
      @cartsitem.amount = @cartsitem.amount - @item.rate
      @cartsitem.quantity = @cartsitem.quantity-1
      if @cartsitem.quantity >0 
        @cart.save
        @cartsitem.save
      else 
        session[:cartsitem_id]=nil
        @cartsitem.destroy
      end 
    end
    # redirect_to '/'
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js {   }
      format.json { render fruit_id: @item.id , cartsitem_id: @cartsitem.id , cart_id: @cart.id }
    end
  end

  def removeVegetable
    @item = Vegetable.find(params[:vegetable_id])
    if @cartsitem = Cartsitem.all.find_by(cart_id: @cart.id , vegetable_id: @item.id)
      session[:cartsitem_id] = @cartsitem.id
    end
    if @cartsitem
      @cartsitem.amount = @cartsitem.amount - @item.rate
      @cartsitem.quantity = @cartsitem.quantity-1
      if @cartsitem.quantity >0 
        @cart.save
        @cartsitem.save
      else 
        session[:cartsitem_id]=nil
        @cartsitem.destroy
      end 
    end


   
    # redirect_to '/'
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js {   }
      format.json { render vegetable_id: @item.id , cartsitem_id: @cartsitem.id , cart_id: @cart.id }
    end
  end


  def addfruit
    @fruit = Fruit.find(params[:fruit_id])
    if @cartsitem = Cartsitem.all.find_by(cart_id: @cart.id , fruit_id: @fruit.id)
      session[:cartsitem_id] = @cartsitem.id
    end
    if @cartsitem
      @cartsitem.amount = @cartsitem.amount + @fruit.rate
      @cartsitem.quantity = @cartsitem.quantity+1
    else
      @cartsitem = Cartsitem.create
      session[:cartsitem_id] = @cartsitem.id
      @cartsitem.cart_id = @cart.id
      @cartsitem.fruit_id = @fruit.id 
      @cartsitem.item = @fruit.name
      @cartsitem.quantity = 1
      @cartsitem.weight = @fruit.weight
      @cartsitem.weightin = @fruit.weightin
      @cartsitem.amount = @fruit.rate
      @cartsitem.user_id = current_user.id   
    end

    @cart.save!
    @cartsitem.save!
    # redirect_to '/'
    
    respond_to do |format|
      format.html { redirect_to '/' }
      format.js {   }
      format.json { render fruit_id: @fruit.id , cartsitem_id: @cartsitem.id , cart_id: @cart.id }
    end
  end


  def addvegetable
    
          # @cart = Cart.create
          # session[:cart_id] = @cart.id
       # @vegetable = Vegetable.find(params[:vegetable_id])
       # if @vegetable
       #  if @cart.quantity
       #     @cart.quantity = @cart.quantity+1
       #  else
       #     @cart.vegetable_id = @vegetable.id 
       #     @cart.item = @vegetable.name
       #     @cart.quantity = 1
       #     @cart.amount = @vegetable.rate
       #     @cart.user_id = current_user.id
       #  end
       #  @cart.save!         
       # else
       # end      
       # redirect_to '/'
       
       
    @vegetable = Vegetable.find(params[:vegetable_id])
    if @cartsitem = Cartsitem.all.find_by(cart_id: @cart.id , vegetable_id: @vegetable.id)
      session[:cartsitem_id] = @cartsitem.id
    end
    if @cartsitem
      @cartsitem.quantity = @cartsitem.quantity+1
      @cartsitem.amount = @cartsitem.amount + @vegetable.rate
    else
      @cartsitem = Cartsitem.create
      session[:cartsitem_id] = @cartsitem.id
      @cartsitem.cart_id = @cart.id
      @cartsitem.vegetable_id = @vegetable.id 
      @cartsitem.item = @vegetable.name
      @cartsitem.quantity = 1
      @cartsitem.amount = @vegetable.rate
      @cartsitem.weight = @vegetable.weight
      @cartsitem.weightin = @vegetable.weightin
      @cartsitem.user_id = current_user.id   
    end

    @cart.save!
    @cartsitem.save!
    redirect_to '/'
  end

  def ajax
    render :json => {text: "text"}
  end

  def about
    
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.fetch(:home, {})
    end
end
