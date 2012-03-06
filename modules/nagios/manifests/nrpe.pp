class nagios::nrpe {

  case $operatingsystem {
    "freebsd": {
      $nrpeservice = "nrpe2"
      $nrpepattern = "nrpe2"
      $nrpepackage = "nrpe2"
      $nrpedir     = "/usr/local/etc"
      $nagiosuser  = "root"
      $nagiosgroup = "wheel"
      $pluginsdir  = "/usr/local/libexec/nagios"
      $sudopath    = "/usr/local/bin"
    }
    /(Fedora|Red Hat|CentOS)/: {
      $nrpeservice = "nrpe"
      $nrpepattern = "nrpe"
      $nrpepackage = "nrpe"
      $nrpedir     = "/etc/nagios"
      $nagiosuser  = "nrpe"
      $nagiosgroup = "nrpe"
      case $architecture {
        "x86_64": {
          $pluginsdir  = "/usr/lib64/nagios/plugins"
        }
        default: {
          $pluginsdir  = "/usr/lib/nagios/plugins"
        }
      }
      $sudopath    = "/usr/bin"
      $template    = "nagios/nrpe.rpm.cfg"
    }
    default: {
      $nrpeservice = "nagios-nrpe-server"
      $nrpepattern = "nrpe"
      $nrpepackage = "nagios-nrpe-server"
      $nrpedir     = "/etc/nagios"
      $nagiosuser  = "nagios"
      $nagiosgroup = "nagios"
      $pluginsdir  = "/usr/lib/nagios/plugins"
      $sudopath    = "/usr/bin"
      $template    = "nagios/nrpe.deb.cfg"
    }
  }

  file { $pluginsdir:
    mode    => "755",
    require => Package["nagios-plugins"],
    source  => "puppet:///nagios/plugins/",
    purge   => false,
    recurse => true,
  }

  file { "$nrpedir/nrpe.cfg":
    mode    => "644",
    owner   => $nagiosuser,
    group   => $nagiosgroup,
    content => template("nagios/nrpe.cfg"),
    require => Package[$nrpepackage],
  }


  if  ( $operatingsystem == "Ubuntu" ) or ( $operatingsystem == "Debian" ) {
    exec { 'apt-get update':
      command => '/usr/bin/apt-get update'
    }
    package {
      $nrpepackage: ensure => present, require => Exec["apt-get update"];
      "nagios-plugins": ensure => present, require => Exec["apt-get update"];
    }
  }

  if  ( $operatingsystem == "CentOS" ) or ( $operatingsystem == "Fedora" ) or ( $operatingsystem == "RedHat" ) {
    package {
      $nrpepackage: ensure => present;
      "nagios-plugins": ensure => present;
      "nagios-plugins-users": ensure => present;
      "nagios-plugins-load":  ensure => present;
      "nagios-plugins-disk":  ensure => present;
      "nagios-plugins-ntp":   ensure => present;
      "nagios-plugins-dns":   ensure => present;
      "nagios-plugins-procs": ensure => present;
      "nagios-plugins-dummy": ensure => present;
    }
  }

  service { "$nrpeservice":
    ensure    => running,
    enable    => true,
    pattern   => "$nrpepattern",
    subscribe => File["$nrpedir/nrpe.cfg"];
  }
}

