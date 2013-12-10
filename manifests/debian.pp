class sealion::debian (
$build  = hiera('sealion::build',$sealion::params::build)
) inherits sealion::params {

  if str2bool("$sealion::debian::build") {

  }
  else  {
    package  {  'curl':
      ensure  =>  present,
    }

    exec  { 'curl sealion':
      command => "curl -s https://agent.sealion.com | sudo bash /dev/stdin -o ${sealion::key}",
      path    => '/usr/bin/',
      require =>  Package["curl"],
      creates => "/usr/local/sealion-agent",
    }
  }
}
