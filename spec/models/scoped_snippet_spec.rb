require File.dirname(__FILE__) + '/../spec_helper'

describe Snippet do
  dataset :site_snippets
  before do
    Page.current_site = sites(:site1)
  end
  
  it "should report itself site-scoped" do
    Snippet.is_site_scoped?.should be_true
  end

  it "should have a site association" do
    Snippet.reflect_on_association(:site).should_not be_nil
  end

  it "should have a site" do
    snippets(:snippet1).site.should == sites(:site1)
  end
  
  describe "#create" do
    it "should assign to the current site" do
      snippet = Snippet.create(:name => 'test snippet', :content => "blah")
      snippet.site.should == sites(:site1)
    end
  end
  
  describe "#find" do
    before do
      Page.current_site = sites(:site2)
    end
    it "should be scoped to the current site" do
      Snippet.count(:all).should == 1
      snippet = Snippet.find(:first)
      snippet.should_not be_nil
      snippet.name.should == 'site2snippet'
    end
    it "should not return a snippet from another site" do
      snippet = Snippet.find_by_name('site1snippet')
      snippet.should be_nil
      lambda { Snippet.find(snippet_id(:snippet1)) }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
    
end