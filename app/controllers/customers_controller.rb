class CustomersController < ApplicationController
  before_action :authenticate_member!, except: [:index]
  before_action :set_customer, only: %i[ show edit update destroy ]

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
    render json: @customers
  end

  # GET /customers/1 or /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    render json: @customer
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    if @customer.update(customer_params)
      render json: @customer, status: :ok
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.fetch(:customer, {}).permit(:name, :address, :email)
    end
end
