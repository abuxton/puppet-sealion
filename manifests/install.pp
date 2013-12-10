class sealion::install (
) inherits sealion::params{
  case $operatingsystem {
    'RedHat', 'CentOS'  :{
      include redhat
      include installproxy
    }
    /^(Debian|Ubuntu)$/ :{
      include debian
      include installproxy
    }
    default            :{
      fail("unsupported operating system")
    }
  }
}
