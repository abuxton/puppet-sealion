class sealion::stage (
  $64bit  = hiera('sealion::64bit',$sealion::params::64bit)
) inherits sealion::params  {
  include staging
  file { '/tmp/staging/'  :
    ensure => directory,
  }

  case $architecture {
    /_64$/: {
      staging::file { "${sealion::params::64bit_tar}":
        source => "${sealion::params::sealion_url}/${sealion::params::64bit_tar}",
      } 
      staging::extract { $sealion::params::64bit_tar:
        target  => '/tmp/staging',
        creates => '/tmp/staging/$sealion::params::64bit_tar',
        require => Staging::File[$sealion::params::64bit_tar],
        notify  => Exec['sealion Configure Makefile'],
      }
    }
    /86$/: {
      staging::file { "${sealion::params::32bit_tar}":
        source => "${sealion::params::sealion_url}/${sealion::params::32bit_tar}"
      } 
      staging::extract { $sealion::params::32bit_tar:
        target  => '/tmp/staging',
        creates => '/tmp/staging/sealion-agent-package',
        require => Staging::File[$sealion::params::32bit_tar],
        notify  => Exec['sealion Configure Makefile'],
      }
    }
    default:  {
     fail("unsupported architecture")
    }
  }
  package  { 'make':
    ensure => present,
  }

  exec  { 'sealion Configure Makefile':
    command =>  "./configure -o ${sealion::params::key}",
    path    =>  '/usr/bin:/bin:/tmp/staging/sealion-agent-package',
    cwd     =>  '/tmp/staging/sealion-agent-package',
    require =>  Package['make'],
    creates =>  '/tmp/staging/sealion-agent-package/Makefile',
    notify  =>  Exec['sealion Install Agent'],
  }

  exec  { 'sealion Install Agent':
    command =>  'sudo make install', 
    path    =>  '/usr/bin:bin',
    cwd     =>  '/tmp/staging/sealion-agent-package',
    require =>  Package['make'],
    creates => '/usr/local/sealion-agent',
  }




}
