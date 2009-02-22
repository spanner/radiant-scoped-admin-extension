require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  dataset :site_users
  before do
    Page.current_site = sites(:site1)
  end
  
  it "should report itself site-scoped" do
    User.is_site_scoped?.should be_true
  end

  it "should have a site association" do
    Layout.reflect_on_association(:site).should_not be_nil
  end

  describe "creation" do
    it "should assign to the current site" do
      user = User.create(:name => 'test user', :login => 'testy', :email => 'testy@spanner.org', :password => 'password', :password_confirmation => 'password')
      user.site.should == sites(:site1)
    end
  end
  
  describe "retrieval" do
    before do
      Page.current_site = sites(:site2)
    end
    it "should be scoped to the current site" do
      User.count(:all).should == 2
      user = User.find(:first)
      user.should_not be_nil
      user.name.should == 'admin2'
    end
    it "should not return a user from another site" do
      # this is all tested in multi_site/scoped_finder but never mind
      user = User.find_by_name('user1')
      user.should be_nil
      lambda { User.find(user_id(:user1)) }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
      
  describe "with admin marker" do
    it "should authenticate at its own site" do
      Page.current_site = sites(:site2)
      user = User.authenticate('admin2', 'password')
      user.should_not be_nil
      user.should == users(:admin2)
    end
    it "should also authenticate at another site" do
      Page.current_site = sites(:site1)
      user = User.authenticate('admin2', 'password')
      user.should_not be_nil
      user.name.should == 'admin2'
    end
  end

  describe "without admin marker" do
    it "should authenticate at its own site" do
      Page.current_site = sites(:site2)
      user = User.authenticate('user2', 'password')
      user.should_not be_nil
      user.should == users(:user2)
    end
    it "should not authenticate at another site" do
      Page.current_site = sites(:site1)
      user = User.authenticate('user2', 'password')
      user.should be_nil
    end
  end

end