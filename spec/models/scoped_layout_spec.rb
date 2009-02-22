require File.dirname(__FILE__) + '/../spec_helper'

describe Layout do
  dataset :site_layouts
  before do
    Page.current_site = sites(:site1)
  end
  
  it "should report itself site-scoped" do
    Layout.is_site_scoped?.should be_true
  end

  it "should have a site association" do
    Layout.reflect_on_association(:site).should_not be_nil
  end

  it "should have a site" do
    layouts(:layout1).site.should == sites(:site1)
  end
  
  describe "creation" do
    it "should assign to the current site" do
      layout = Layout.create(:name => 'test layout', :content => "blah")
      layout.site.should == sites(:site1)
    end
  end
  
  describe "retrieval" do
    before do
      Page.current_site = sites(:site2)
    end
    it "should be scoped to the current site" do
      Layout.count(:all).should == 1
      layout = Layout.find(:first)
      layout.should_not be_nil
      layout.name.should == 'Site 2 Layout'
    end
    it "should not return a layout from another site" do
      # this is all tested in multi_site/scoped_finder but never mind
      layout = Layout.find_by_name('Site 1 Layout')
      layout.should be_nil
      lambda { Layout.find(layout_id(:layout1)) }.should raise_error ActiveRecord::RecordNotFound
    end
  end
    
end