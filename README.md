# Scoped Admin

This is a simple add-on that uses spanner's multi_site to scope users, snippets and layouts to site. This is done at the ActiveRecord level, effectively making invisible anything that is out of scope.

## Latest

* I've moved the site-chooser into the submenu extension, where it is much better integrated. You'll want to install that too even though it isn't strictly a requirement.

* I'm about to change the interface in `multi_site` to allow model classes to `have_and_belong_to_many` sites. Here that will affect users, who will gain a proper site-access control rather than the current one-or-all arrangement.

## Requirements

* Radiant 0.7.x or 0.8
* our [multi_site](http://github.com/spanner/radiant-multi-site-extension/tree/master).
* [submenu](http://github.com/spanner/radiant-submenu-extension/tree/master), probably

## Installation

	git submodule add git://github.com/spanner/radiant-scoped-admin-extension.git vendor/extensions/scoped_admin
	rake radiant:extensions:scoped_admin:migrate

If you've got a lot of extensions to install, it's a good idea to install everything else first, do the migrations, make sure it's working and then install scoped_admin last. It will probably cause tests to fail in other extensions, and possibly also migrations.

## Next

Everything works now, as far as I know, but the low-level scoping means some awkwardness when you move between sites. An administrator can move a user from one site to another with the dropdown on the edit-user page, for example, but the effect will just be to make that user disappear until you jump to the destination site to see that she arrived. That needs to be improved, or at least better reported.

## See also 

	http://github.com/spanner/radiant-multi-site-extension
	http://github.com/spanner/radiant-paperclipped_multisite-extension

## Author & Copyright

* William Ross, for spanner. will at spanner.org
* Copyright 2008-9 spanner ltd
* released under the same terms as Rails and/or Radiant
