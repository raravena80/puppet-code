class puppet::config {

  include puppet::params


  case $operatingsystem {
    /(Fedora|Red Hat|CentOS)/: {
      $puppetconftemplate    = "puppet/puppet.conf.erb"
    }
    default: {
      $puppetconftemplate    = "puppet/puppet.conf.deb.erb"
    }
  }


  file { "/etc/puppet/puppet.conf":
    ensure => present,
    content => template($puppetconftemplate),
    owner => "puppet",
    group => "puppet",
    require => Class["puppet::install"],
    notify => Class["puppet::service"],
   }    
}


