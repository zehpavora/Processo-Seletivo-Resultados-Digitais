require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe VisitorsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Visitor. As you add validations to Visitor, be sure to
  # adjust the attributes here as well.
  let(:existing_visitor) {
    FactoryGirl.create(:visitor)
  }

  let(:api_key) {
    FactoryGirl.create(:api_key)
  }

  let(:valid_attributes) {
    FactoryGirl.build(:visitor).attributes
  }

  let(:invalid_attributes) {
    { email: '' }
  }

  describe "GET #index" do
    it "assigns all visitors as @visitors" do
      visitor = Visitor.create! valid_attributes
      get :index, {}
      expect(assigns(:visitors)).to eq([visitor])
    end
  end

  describe "GET #show" do
    context "with valid params" do
      it "assigns the requested visitor as @visitor" do
        visitor = Visitor.create! valid_attributes
        get :show, {id: visitor.id}
        expect(assigns(:visitor)).to eq(visitor)
      end
    end

    context "with valid params" do
      it "fails without ID" do
        expect {get(:show, {id: -1})}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Visitor" do
        expect {
          post :create, {api_key: api_key.key, visitor: valid_attributes}
        }.to change(Visitor, :count).by(1)
      end

      it "assigns a newly created visitor as @visitor" do
        post :create, {api_key: api_key.key, visitor: valid_attributes}
        expect(assigns(:visitor)).to be_a(Visitor)
        expect(assigns(:visitor)).to be_persisted
      end

      it "redirects to the created visitor" do
        post :create, {api_key: api_key.key, visitor: valid_attributes}
        expect(response).to redirect_to(Visitor.last)
      end
    end

    context "with invalid params" do
      it "returns the errors in the model" do
        post :create, {format: :json, api_key: api_key.key, visitor: invalid_attributes}

        test_visitor = Visitor.new(invalid_attributes)
        test_visitor.valid?

        expect(response.body).to eq(test_visitor.to_json)
      end

      it "fails without API Key" do
        post :create, {format: :json, visitor: valid_attributes}
        expect(response).to have_http_status(401)
      end

      it "fails with wrong API Key" do
        post :create, {format: :json, api_key: '0', visitor: valid_attributes}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "assigns the desired visitor as @visitor" do
        attributes = existing_visitor.attributes.merge(email: FFaker::Internet.email)
        put :update, {format: :json, api_key: api_key.key, id: existing_visitor.id, visitor: attributes}

        expect(assigns(:visitor)).to be_a(Visitor)
        expect(assigns(:visitor)).to be_persisted
      end
    end

    context "with invalid params" do
      it "returns the errors in the model" do
        attributes = existing_visitor.attributes.merge(email: '')
        put :update, {format: :json, api_key: api_key.key, id: existing_visitor.id, visitor: attributes}

        test_visitor = Visitor.new(attributes)
        test_visitor.valid?

        expect(response.body).to eq(test_visitor.to_json)
      end

      it "fails without API Key" do
        put :update, {format: :json, id: existing_visitor.id, api_key: '', visitor: valid_attributes}
        expect(response).to have_http_status(401)
      end

      it "fails with wrong API Key" do
        put :update, {format: :json, id: existing_visitor.id, api_key: '0', visitor: valid_attributes}
        expect(response).to have_http_status(401)
      end
    end
  end
end