name 'ds2'
maintainer 'Qiulin Wang'
maintainer_email 'wangql.dev@gmail.com'
license ''
description 'Installs/Configures ds2'
long_description 'Installs/Configures ds2'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/ds2/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/ds2'

depends 'apache2', '~> 5.0.1'
depends 'mysql', '~> 8.5.1'
depends 'mysql-replication', '~> 2.0.0'
depends 'redisio', '~> 2.7.1'
