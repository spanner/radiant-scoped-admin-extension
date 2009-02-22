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




end