# == Class: sealion
#
# installer class for sealion Linux monitoring application
# http://sealion.com
# You will require a sealion user account and unique key
#
# === Parameters
#
# Document parameters here.
#
#
# === Variables
#
# Here you should define a list of variables that this module would require.
# [ sealion-key ]
# the unique key defined by sealion in your user account. 
#
# === Examples
#
#  class { sealion:
#
#  }
#
# === Authors
#
# Author Name <adam.buxton@puppetlabs.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class sealion (
  $key   =   hiera( 'sealion::sealion-key',$sealion::params::key  ),
) inherits sealion::params {
  if ($sealion::params::key != 'false'){
    include sealion::install
  }
  else  {
    fail("You have not set your unique sealion user key in params.pp") 
  }
}
