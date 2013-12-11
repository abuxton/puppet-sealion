# == Class: sealion
#
# installer class for sealion Linux monitoring application
# http://sealion.com
# You will require a sealion user account and unique key
#
# === Parameters
#
# See params.pp
#
#
# === Variables
#
# Here you should define a list of variables that this module would require.
# [ sealion-key ] the unique key defined by sealion in your user account. 
# [ proxy_url ] url to be used if behind a proxy
#
# === Examples
#
#  class { sealion:
#
#  }
#
# === Authors
#
# Author Name abuxton@github, digitaladept
#
class sealion (
  $key   =   hiera( 'sealion::key',$sealion::params::key  ),
) inherits sealion::params {
  if ($sealion::params::key != 'false'){
    include sealion::install
  }
  else  {
    fail("You have not set your unique sealion user key in params.pp") 
  }
}
