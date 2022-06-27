require 'rails_helper'

RSpec.describe "Customers",  type: :request do
  describe "GET /customers" do

    before do
      @member = create(:member)
      @customer = create(:customer)
      @customer.save
    end

    it "index - Arr JSON 200 ok" do
      get customers_path
      expect(response).to have_http_status(200)

      # No Rails c, crie um customer caso não exista
      # a = FactoryBot.create(:customer)

      expect(response.body).to include_json([
          id: @customer.id,
          name: @customer.name,
          email: @customer.email,
          address: @customer.address
      ])
    end

    it "show - Arr JSON 200 ok (using JSON schema)" do
      sign_in(@member)
      get '/customers/1'
      expect(response).to match_response_schema("customer")

      # No Rails c, crie um customer caso não exista
      # a = FactoryBot.create(:customer)

      # expect(response.body).to include_json([
      #     id: @customer.id,
      #     name: @customer.name,
      #     email: @customer.email,
      #     address: @customer.address
      # ])
    end

    it "show - Single JSON 200 ok" do
      sign_in(@member)
      get '/customers/1'
      expect(response).to have_http_status(200)

      # No Rails c, crie um customer caso não exista
      # a = FactoryBot.create(:customer)

      # expect(response.body).to include_json(
      #     id: @customer.id,
      #     name: @customer.name,
      #     email: @customer.email,
      #     address: @customer.address
      # )

      # Matchers para include_json
      expect(response.body).to include_json(
        id: (be_kind_of Integer),
        name: (be_kind_of String),
        email: (be_kind_of String),
        address: (be_kind_of String)
      )
    end

    it "show - Single JSON 200 ok" do
      sign_in(@member)
      get '/customers/1'

      # Rspec puro com JSON
      response_body = JSON.parse(response.body)
      expect(response_body.fetch("id") ).to eq(1)
      expect(response_body.fetch("name") ).to be_kind_of(String)
    end

    it 'Create - JSON' do

      # sign_in(@member)
      login_as(@member, scope: :member)

      headers = {"ACCEPT" => "application/json"}

      # attributes_for vêm da factory
      customer_params = attributes_for(:customer)

      post "/customers", params: { customer: customer_params }, headers: headers

      expect(response.body).to include_json(
        id: (be_kind_of Integer),
        name: customer_params[:name],
        email: customer_params[:email],
        address: customer_params.fetch(:address)
      )

    end

    it 'Update - JSON' do

      # sign_in(@member)
      login_as(@member, scope: :member)

      headers = {"ACCEPT" => "application/json"}

      # attributes_for vêm da factory
      customer = Customer.first
      customer.name = Faker::Name.name

      patch "/customers/#{customer.id}", params: { customer: {name: customer.name} }, headers: headers

      expect(response.body).to include_json(
        id: (be_kind_of Integer),
        name: customer.name
      )

    end

    it 'Delete - JSON' do

      # sign_in(@member)
      login_as(@member, scope: :member)

      headers = {"ACCEPT" => "application/json"}

      customer = Customer.first

      expect {
        delete "/customers/#{customer.id}", headers: headers
      }.to change(Customer, :count).by(-1)

    end
  end
end
