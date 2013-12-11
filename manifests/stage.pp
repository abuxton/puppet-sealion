class sealion:stage (
  $64bit  = hiera('sealion::64bit',$sealion::params::64bit)
) inherits sealion:params  {
  include staging
  if str2bool($64bit)
    staging::file { $sealion::params::64bit_tar:
      source => "${sealion::params::sealion_url}/${sealion::params::64bit_tar}"
    } 
    staging::extract { $sealion::params::64bit_tar:
      target  => '/tmp/staging',
      creates => '/tmp/staging/$sealion::params::64bit_tar',
      require => Staging::File[$sealion::params::64bit_tar],
    }
  }
  else  {
    staging::file { $sealion::params::32bit_tar:
      source => "${sealion::params::sealion_url}/${sealion::params::32bit_tar}"
    } 
    staging::extract { $sealion::params::32bit_tar:
      target  => '/tmp/staging',
      creates => '/tmp/staging/$sealion::params::32bit_tar',
      require => Staging::File[$sealion::params::32bit_tar],
    }
  }
}
