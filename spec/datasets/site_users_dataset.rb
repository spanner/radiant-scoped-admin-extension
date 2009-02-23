class SiteUsersDataset < Dataset::Base
  uses :users, :sites
  
  def load
    create_user "user1", :site => sites(:site1)
    create_user "user2", :site => sites(:site2)
    create_user "admin1", :site => sites(:site1), :admin => true
    create_user "admin2", :site => sites(:site2), :admin => true
    create_user "anyone", :site => sites(:default), :admin => false
  end

end
