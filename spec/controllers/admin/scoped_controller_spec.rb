require File.dirname(__FILE__) + "/../../spec_helper"

describe Admin::SnippetsController do
  dataset :site_users

  describe "a local user" do
    before do
      login_as(:anyone)
    end

    it "should be able to access her site" do
      get :index
      response.should be_success
      response.should render_template('index')
    end
  
    it "should not be able to access another site" do
      get :index, :site_id => site_id(:site1)
      response.should be_redirect
      response.should redirect_to(login_url)
    end
  end
  
  describe "a global user" do
    before do
      login_as(:shareduser)
    end
    
    it "should be able to access any site" do
      get :index
      response.should be_success
      response.should render_template('index')
    end
    
    describe "submitting a site_id parameter" do
      before do 
        get :index, :site_id => site_id(:site1)
      end
  
      it "should be allowed access" do
        response.should be_success
        response.should render_template('index')
      end
      
      it "should see the right site" do
        Page.current_site.should == sites(:site1)
      end
    
      it "should get the site id in the session" do
        session[:site_id].should.to_s == site_id(:site1).to_s
      end
    end
  end
end