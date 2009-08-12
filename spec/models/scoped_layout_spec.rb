require File.dirname(__FILE__) + '/../spec_helper'

describe Layout do
  dataset :site_layouts
  before do
    Page.stub!(:current_site).and_return(sites(:site1))
  end
  
  it "should report itself site-scoped" do
    Layout.is_site_scoped?.should be_true
  end

  it "should not report itself shareable" do
    Layout.is_shareable?.should_not be_true
  end

  it "should have a site association" do
    Layout.reflect_on_association(:site).should_not be_nil
  end

  it "should have a site" do
    layouts(:layout1).site.should == sites(:site1)
  end
  
  describe "on creation" do
    it "should assign to the current site automatically" do
      layout = Layout.create(:name => 'test layout', :content => "blah")
      layout.site.should == sites(:site1)
    end

    it "should be invalid if its name is already in use on this site" do
      layout = Layout.new(:name => 'Site 1 Layout', :content => "blah", :site => sites(:site1))
      layout.valid?.should be_false
      layout.errors.should_not be_nil
      layout.errors.on(:name).should_not be_nil
    end

    it "should be valid if its name is already in use on another site" do
      layout = Layout.new(:name => 'Site 2 Layout', :content => "blah", :site => sites(:site1))
      layout.valid?.should be_true
    end
  end
  
  describe "on retrieval" do
    before do
      Page.stub!(:current_site).and_return(sites(:site2))
    end
    it "should be scoped to the current site and not shared" do
      Layout.count(:all).should == 1
      layout = Layout.find(:first)
      layout.should_not be_nil
      layout.name.should == 'Site 2 Layout'
    end
  end
    
end