class sealion::installproxy (
  $proxy_url  = hiera('sealion::proxy_url',$sealion::params::proxy_url),
) inherits sealion::params {
  if str2bool("${sealion::params::proxy}") {
    file  { '/usr/local/sealion-agent/etc/config/proxy.json'  :
      ensure  => file,
      content => "puppet:///modules/sealion/proxy/proxy.json.erb"
    }
  }
  else{
    #no action required but left here just incase!
  } 
}
