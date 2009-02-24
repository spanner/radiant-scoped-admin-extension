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
    it "should not assign to the current site by default" do
      user = User.create(:name => 'test user', :login => 'testy', :email => 'testy@spanner.org', :password => 'password', :password_confirmation => 'password')
      user.site.should be_nil
    end
  end
  
  describe "retrieval" do
    before do
      Page.current_site = sites(:site2)
    end
    it "should get users from the current site and any without a site" do
      User.count(:all).should == 9
      user = User.find(:first)
      user.should_not be_nil
      user.name.should == 'Admin'
    end
    it "should not return a user from another site" do
      # this is all tested in multi_site/scoped_finder but never mind
      user = User.find_by_name('user1')
      user.should be_nil
      lambda { User.find(user_id(:user1)) }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "on login" do
    describe "with no site" do
      it "should authenticate at any site" do
        Page.current_site = sites(:site1)
        user = User.authenticate('shareduser', 'password')
        user.should_not be_nil
        user.name.should == 'shareduser'
        Page.current_site = sites(:site2)
        user = User.authenticate('shareduser', 'password')
        user.should_not be_nil
        user.name.should == 'shareduser'
      end
    end

    describe "with a site" do
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
end