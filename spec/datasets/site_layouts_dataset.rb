class SiteLayoutsDataset < Dataset::Base
  uses :sites
  
  def load
    create_model Layout, :layout1, :name => 'Site 1 Layout', :site => sites(:site1), :content => <<-CONTENT
<html>
  <head>
    <title>Layout1: <r:title /></title>
  </head>
  <body>
    <r:content />
  </body>
</html>
    CONTENT

    create_model Layout, :layout2, :name => 'Site 2 Layout', :site => sites(:site2), :content => <<-CONTENT
<html>
  <head>
    <title>Layout2: <r:title /></title>
  </head>
  <body>
    <r:content />
  </body>
</html>
    CONTENT

  end
end
