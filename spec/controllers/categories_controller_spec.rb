require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  it 'responds successfully' do
    get :index
    expect(response).to have_http_status(:ok)
  end

  context 'Not Authorized' do
    it 'Responds a 302 response (not authorized)' do
      customer = create(:customer)
      get :show, params: {id: customer.id}
      expect(response).to have_http_status(302)
    end
  end

  it '' do
    member = create(:member)
    customer = create(:customer)

    sign_in member

    get :show, params: {id: customer.id}
    expect(response).to have_http_status(200)
  end
end
