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

  package {
    $nrpepackage: ensure => present;
    "nagios-plugins": ensure => present;
  }

  service { "$nrpeservice":
    ensure    => running,
    enable    => true,
    pattern   => "$nrpepattern",
    subscribe => File["$nrpedir/nrpe.cfg"];
  }
}
