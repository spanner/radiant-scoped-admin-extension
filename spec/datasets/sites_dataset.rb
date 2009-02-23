class SitesDataset < Dataset::Base
  uses :site_pages
  
  def load
    create_record Site, :site1, :name => 'Site1', :domain => 'site1', :base_domain => 'site1.domain.com', :position => 1, :homepage_id => page_id(:home)
    create_record Site, :site2, :name => 'Site2', :domain => 'site2', :base_domain => 'site2.domain.com', :position => 2, :homepage_id => page_id(:home2)
    create_record Site, :default, :name => 'Default', :domain => 'test', :base_domain => 'test.host', :position => 3, :homepage_id => page_id(:home3)
  end
end
