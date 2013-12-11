class sealion::install (
) inherits sealion::params{

  case $operatingsystem {
    'RedHat', 'CentOS'  :{
      include redhat

    }
    /^(Debian|Ubuntu)$/ :{
      include debian
    }
    default            :{
      fail("unsupported operating system")
    }
  }
  include installproxy
  
}
