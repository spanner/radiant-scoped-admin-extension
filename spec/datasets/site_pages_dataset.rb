class SitePagesDataset < Dataset::Base
  uses :home_page
  
  def load
    create_page "Home2", :parent_id => nil do
      create_page "ChildOfHome2" do
        create_page "GrandchildOfHome2"
      end
      create_page "Child2OfHome2"
      create_page "Child3OfHome2"
    end
    create_page "Home3", :parent_id => nil
  end
end
