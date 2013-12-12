# == Class: sealion
#
# installer class for sealion Linux monitoring application
# http://sealion.com
# You will require a sealion user account and unique key
#
# === Parameters
#
# See params.pp
# $key        = 'false' replace with your unique user key
# $build      = 'false' true if you wish to build from source
# $proxy      = 'false' true if you run behind proxy as docs
# $proxy_url  = '' proxy url! 
# $sealion_url= 'https://s3.amazonaws.com/sealion.com' source foler at tiem of writing
# $32bit_tar  = 'sealion-agent-package_i686.tar.gz' 
# $64bit_tar  = 'sealion.com/sealion-agent-package_x86_64.tar.gz'
#
# === Variables
#
# Here you should define a list of variables that this module would require.
# [ sealion-key ] the unique key defined by sealion in your user account. 
# [ proxy_url ] url to be used if behind a proxy
#
# === Examples
# include sealion
#
# === Authors
#
#  abuxton
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
