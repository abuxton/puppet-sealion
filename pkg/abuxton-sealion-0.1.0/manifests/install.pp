class sealion::install (
) inherits sealion::params{

  case $operatingsystem {
    'RedHat', 'CentOS'  :{
      include linux

    }
    /^(Debian|Ubuntu)$/ :{
      include linux
    }
    default            :{
      fail("unsupported operating system")
    }
  }
  include installproxy
  
}
