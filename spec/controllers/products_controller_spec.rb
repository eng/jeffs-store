require 'spec_helper'

describe ProductsController do
  let (:product_a) { FactoryGirl.build(:product) }
  let (:product_b) { FactoryGirl.build(:product) }
  let (:products) { [product_a, product_b] }
  
  describe :index do
    before :each do
      Product.should_receive(:all).and_return(products)
    end

    it "loads the product list" do
      get :index
      assigns(:products).should eq(products)
    end

    it "renders the index view for html" do
      get :index
      response.should render_template(:index)
    end

    it "renders json for json" do
      get :index, format: :json
      json = JSON.parse(response.body)
      json.length.should eq(2)
    end
  end

  describe :show do
    before :each do
      Product.should_receive(:find).and_return(product_a)
      product_a.stub(:id).and_return(37)
    end

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
    before :each do
      Product.should_receive(:find).and_return(product_a)
      product_a.stub(:id).and_return(37)
    end
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
    before :each do
      product_a
      product_a.stub(:id).and_return(37)
      Product.should_receive(:new).and_return(product_a)
    end

    describe :success do
      before :each do
        product_a.should_receive(:save).and_return(true)
      end

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
      before :each do
        product_a.should_receive(:save).and_return(false)
      end
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
    before :each do
      Product.should_receive(:find).and_return(product_a)
      product_a.stub(:id).and_return(37)
    end

    describe :success do
      before :each do
        product_a.should_receive(:update_attributes).and_return(true)
      end
      it "updates a product" do
        put :update, id: product_a.id, product: { name: "Puck" }
      end

      it "redirects to show the product" do
        put :update, id: product_a.id, product: { name: "Puck" }
        response.should redirect_to product_url(product_a)
      end
    end

    describe :failure do
      before :each do
        product_a.should_receive(:update_attributes).and_return(false)
      end
      it "does not update a product" do
        name = product_a.name
        put :update, id: product_a.id, product: { name: "" }
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
