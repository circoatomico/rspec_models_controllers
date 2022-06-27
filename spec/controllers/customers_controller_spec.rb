require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  it 'responds successfully' do
    get :index
    expect(response).to have_http_status(:ok)
  end

  context 'As a Guest' do
    it 'Responds a 302 response (not authorized)' do
      customer = create(:customer)
      get :show, params: {id: customer.id}
      expect(response).to have_http_status(302)
    end
  end

  context 'as Logged Member' do
    before do
      @member = create(:member)
      @customer = create(:customer)
    end

    # shoulda matchers
    it { should route(:get, '/customers').to(action: :index) }

    it 'With valid params' do
      customer_params = attributes_for(:customer)
      sign_in @member

      # puts customer_params

      expect {
        post :create, params: {customer: customer_params }
      }.to change(Customer, :count).by(1)

    end

    it 'With invalid params' do
      customer_params = attributes_for(:customer, address: nil)
      sign_in @member

      # puts customer_params
      post :create, params: {customer: customer_params }

      expect(response).to have_http_status(422)

    end

    it 'respond success to visualize a customer' do
      sign_in @member

      get :show, params: {id: @customer.id}
      expect(response).to have_http_status(200)
    end

    it 'Contect-Type' do
      sign_in @member

      get :show, format: :json, params: {id: @customer.id}
      expect(response.content_type).to match(/application\/json/)

    end
  end
end
