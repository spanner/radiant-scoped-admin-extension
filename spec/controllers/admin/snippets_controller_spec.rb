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
  
  describe "for an global admin user" do
    before do
      login_as(:sharedadmin)
    end
    
    describe "with a simple request" do
      before do
        get :index
      end
      
      it "should set current_site" do
        Page.current_site.should == sites(:default)
      end
    end
    
    describe "with a site parameter" do
      it "should set current_site to that site" do
        get :index, :site => site_id(:site2)
        Page.current_site.should == sites(:site2)
      end
    end
    
    describe "with a root parameter" do
      before do
        get :index, :root => page_id(:home2)
      end
      it "should set current_site to the site of that root page" do
        Page.current_site.should == sites(:site2)
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
  
    describe "with site parameters" do
      it "should ignore them" do
        get :index, :site => site_id(:site2), :root => page_id(:home2)
        Page.current_site.should == sites(:default)
      end
    end
  end
  
  
  
  
  
  
  
  
  
  
end