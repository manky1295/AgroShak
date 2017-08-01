class VegetablesController < ApplicationController
  before_action :set_vegetable, only: [:show, :edit, :update, :destroy]

  # GET /vegetables
  # GET /vegetables.json
  def index
    @vegetables = Vegetable.all
     @carts = Cart.all
  end

  # GET /vegetables/1
  # GET /vegetables/1.json
  def show
  end

  # GET /vegetables/new
  def new
    @vegetable = Vegetable.new
  end

  # GET /vegetables/1/edit
  def edit
  end

  # POST /vegetables
  # POST /vegetables.json
  def create
    @vegetable = Vegetable.new(vegetable_params)

    respond_to do |format|
      if @vegetable.save
        format.html { redirect_to '/moderator', notice: 'Vegetable was successfully created.' }
        format.json { render :show, status: :created, location: @vegetable }
      else
        format.html { render :new }
        format.json { render json: @vegetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vegetables/1
  # PATCH/PUT /vegetables/1.json
  def update
    respond_to do |format|
      if @vegetable.update(vegetable_params)
        format.html { redirect_to '/moderator', notice: 'Vegetable was successfully updated.' }
        format.json { render :show, status: :ok, location: @vegetable }
      else
        format.html { render :edit }
        format.json { render json: @vegetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vegetables/1
  # DELETE /vegetables/1.json
  def destroy
    @vegetable.destroy
    respond_to do |format|
      format.html { redirect_to vegetables_url, notice: 'Vegetable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vegetable
      @vegetable = Vegetable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vegetable_params
      params.require(:vegetable).permit(:name, :rate, :quantity ,:weight , :weightin)
    end


     def addfruit

  
        # @cart = Cart.create
        # session[:cart_id] = @cart.id
     @fruit = Fruit.find(params[:fruit_id])
     if @fruit
      if @cart.quantity
         @cart.quantity = @cart.quantity+1
      else
         @cart.fruit_id = @fruit.id 
         @cart.item = @fruit.name
         @cart.quantity = 1
         @cart.amount = @fruit.rate
      end
      @cart.save!
     
       
     else
       

     end
    
     redirect_to '/'
  end

end
