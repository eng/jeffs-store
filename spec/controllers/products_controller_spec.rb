require 'spec_helper'

describe ProductsController do
  let (:product_a) { FactoryGirl.create(:product) }
  let (:product_b) { FactoryGirl.create(:product) }
  let (:products) { [product_a, product_b] }
  
  describe :index do
    it "loads the product list" do
      products # ensure everything's loaded in the DB
      get :index
      assigns(:products).should eq(products)
    end

    it "renders the index view for html" do
      get :index
      response.should render_template(:index)
    end

    it "renders json for json" do
      products
      get :index, format: :json
      json = JSON.parse(response.body)
      json.length.should eq(2)
    end
  end

  describe :show do
    it "loads the proper product" do
      get :show, id: product_a.id
      assigns(:product).should eq(product_a)
    end

    it "renders the show template" do
      get :show, id: product_a.id
      response.should render_template(:show)
    end
  end

  describe :new do
    it "initializes a new product" do
      get :new
      assigns(:product).attributes.should eq(Product.new.attributes)
    end

    it "renders the new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe :edit do
    it "finds a product" do
      get :edit, id: product_a.id
      assigns(:product).should eq(product_a)
    end

    it "renders the edit template" do
      get :edit, id: product_a.id
      response.should render_template(:edit)
    end
  end

  describe :create do
    describe :success do
      it "creates a new product" do
        lambda {
          post :create, product: FactoryGirl.attributes_for(:product)
        }.should change(Product, :count).by(1)
      end

      it "redirects to the show path" do
        post :create, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to product_url(assigns(:product))
      end
    end

    describe :failure do
      it "doesn't create a product" do
        lambda {
          post :create, product: { foo: "bar" }
        }.should_not change(Product, :count)
      end

      it "renders the new template" do
        post :create, product: { foo: "bar" }
        response.should render_template :new
      end
    end
  end

  describe :update do
    describe :success do
      it "updates a product" do
        put :update, id: product_a.id, product: { name: "Puck" }
        product_a.reload.name.should eq("Puck")
      end

      it "redirects to show the product" do
        put :update, id: product_a.id, product: { name: "Puck" }
        response.should redirect_to product_url(product_a)
      end
    end

    describe :failure do
      it "does not update a product" do
        name = product_a.name
        put :update, id: product_a.id, product: { name: "" }
        product_a.reload.name.should eq(name)
      end

      it "renders the edit action" do
        put :update, id: product_a.id, product: { name: "" }
        response.should render_template(:edit)
      end
    end
  end

  describe :delete do
    it "deletes a product" do
      product_a
      lambda {
        delete :destroy, id: product_a.id
      }.should change(Product, :count).by(-1)
    end
  end

end
