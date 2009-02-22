class SiteUsersDataset < Dataset::Base
  uses :users, :sites
  
  def load
    create_user "site1", :name => "Site 1 User", :site => sites(:site1)
    create_user "site2", :name => "Site 2 User", :site => sites(:site2)
  end

end
