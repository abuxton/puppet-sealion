class sealion::stage (
  $64bit  = hiera('sealion::64bit',$sealion::params::64bit)
) inherits sealion::params  {
  include staging
  file { '/tmp/staging/'  :
    ensure => directory,
  }

  if str2bool($64bit) {
    staging::file { "${sealion::params::64bit_tar}":
      source => "${sealion::params::sealion_url}/${sealion::params::64bit_tar}",
    } 
    staging::extract { $sealion::params::64bit_tar:
      target  => '/tmp/staging',
      creates => '/tmp/staging/$sealion::params::64bit_tar',
      require => Staging::File[$sealion::params::64bit_tar],
    }
  }
  else  {
    staging::file { "${sealion::params::32bit_tar}":
      source => "${sealion::params::sealion_url}/${sealion::params::32bit_tar}"
    } 
    staging::extract { $sealion::params::32bit_tar:
      target  => '/tmp/staging',
      creates => '/tmp/staging/sealion-agent-package',
      require => Staging::File[$sealion::params::32bit_tar],
    }
  }
  package  { 'make':
    enure => present,
  }

  exec  { 'sealion Configure Makefile':
    cmd     =>  "/tmp/staging/sealion-agent-package/configure -o ${sealion::params::key}",
    require =>  Package['make'],
    creates =>  '/tmp/staging/sealion/agent-package/Makefile',
    notify  =>  Exec['sealion Install Agent'],
  }

  exec  { 'sealion Install Agent':
    cmd     =>  'sudo /tmp/staging/sealion-agent-package/make install',
    creates => '/usr/local/sealion-agent',





}
