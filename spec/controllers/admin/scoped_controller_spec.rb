require File.dirname(__FILE__) + "/../../spec_helper"

# class StubController < Admin::ResourceController
#   # include ScopedAdmin::ResourceController
#   def index; end
#   def rescue_action(e) raise e end
# end

describe Admin::SnippetsController do
  dataset :site_users

  before do
    map = ActionController::Routing::RouteSet::Mapper.new(ActionController::Routing::Routes)
    map.connect ':controller/:action/:id'
    ActionController::Routing::Routes.named_routes.install
  end
   
  after do
    ActionController::Routing::Routes.reload
  end
  
  describe "for a global admin user" do
    before do
      login_as(:sharedadmin)
    end
    
    describe "with a simple request" do
      before do
        get :index
      end
      
      it "should set current_site to the site logged into" do
        Page.current_site.should == sites(:default)
      end
    end
    
    describe "with a site parameter" do
      it "should set current_site to that site" do
        get :index, :site_id => site_id(:site2)
        Page.current_site.should == sites(:site2)
      end
    end
  end

  describe "for a local admin user" do

    before do
      @site = sites(:site2)
      @host = @site.base_domain
      @cookies = {}
      request.stub!(:host).and_return(@host)
      controller.stub!(:cookies).and_return(@cookies)
    end
    
    describe "at the right site" do
      before do
        lambda{login_as(:admin2)}.should_not raise_error(ActiveRecord::RecordNotFound)
        get :index
      end
      
      it "should allow access" do
        response.should be_success
        response.should render_template('index')
      end

      it "should set current_site" do
        Page.current_site.should == sites(:site2)
      end
    end
    
    describe "at the wrong site" do      
      before do
        lambda{login_as(:admin1)}.should raise_error(ActiveRecord::RecordNotFound)
        get :index
      end
      it "should redirect to login" do
        response.should be_redirect
        response.should redirect_to(login_url)
      end
    end
    
    describe "with a site parameter" do
      it "should ignore it" do
        get :index, :site => site_id(:default)
        Page.current_site.should == sites(:site2)
      end
      it "should not set a site_id cookie" do
        @cookies = {}
        controller.stub!(:cookies).and_return(@cookies)
        @cookies.should_not_receive(:[]=)
        get :index, :site => site_id(:default)
      end
    end
  end

  describe "for a local user" do
    before do
      login_as :anyone
    end
    
    describe "with a simple request" do
      it "should set current_site" do
        get :index
        Page.current_site.should == sites(:default)
      end
    end
  
    describe "with site parameters" do
      it "should ignore them" do
        get :index, :site => site_id(:site2), :root => page_id(:home2)
        Page.current_site.should == sites(:default)
      end
    end
  end
  
  describe "for a global non-admin user" do
    before do
      login_as :shareduser
    end
    
    describe "with a simple request" do
      it "should set current_site" do
        get :index
        Page.current_site.should == sites(:default)
      end
    end
  
    describe "with a site parameter" do
      it "should set current_site to that site" do
        get :index, :site_id => site_id(:site2)
        Page.current_site.should == sites(:site2)
      end
    end
  end
end