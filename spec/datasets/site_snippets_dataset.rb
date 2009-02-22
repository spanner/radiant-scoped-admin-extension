class SiteSnippetsDataset < Dataset::Base
  uses :sites
  
  def load
    create_model :snippet, :snippet1, :name => "site1snippet", :content => "testing site 1", :site => sites(:site1)
    create_model :snippet, :snippet2, :name => "site2snippet", :content => "testing site 2", :site => sites(:site2)
  end
end
