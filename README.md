# Scoped Admin

This is a simple add-on that uses spanner's multi_site to scope users, snippets and layouts to site. This is done at the ActiveRecord level, effectively making invisible anything that is out of scope.

## Requirements

* Radiant 0.7.x or 0.8
* our [multi_site](http://github.com/spanner/radiant-multi-site-extension/tree/master).

## Installation

	git submodule add git://github.com/spanner/radiant-scoped-admin-extension.git vendor/extensions/scoped_admin
	rake radiant:extensions:scoped_admin:migrate

If you've got a lot of extensions to install, it's a good idea to install everything else first, do the migrations, make sure it's working and then install scoped_admin last. It will probably cause tests to fail in other extensions, and possibly also migrations.

## Next

Everything works now, as far as I know, but the low-level scoping means some awkwardness when you move between sites. An administrator can move a user from one site to another with the dropdown on the edit-user page, for example, but the effect will just be to make that user disappear until you jump to the destination site to see that she arrived. That needs to be improved, or at least better reported.

I would also like users to have_and_belong_to_many sites, but that's going to take a bit more administration and I'll probably need to introduce the concept of a master site for each installation where you can set site and user parameters. That's under development, as radiant-host-extension, and will probably happen separately to this simple demonstration.

## See also 

	http://github.com/spanner/radiant-multi-site-extension
	http://github.com/spanner/radiant-paperclipped_multisite-extension

## Author & Copyright

* William Ross, for spanner. will at spanner.org
* Copyright 2008-9 spanner ltd
* released under the same terms as Rails and/or Radiant
