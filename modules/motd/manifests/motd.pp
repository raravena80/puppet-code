class motd {

  package { "lsb" :
    name => $operatingsystem ? {
      /(RedHat|CentOS|Fedora)/ => "redhat-lsb",
      /(Debian|Ubuntu)/ => "lsb-release",
    },
    ensure => installed,
  }

  file { "/etc/motd" :
    mode => 444,
    content => template("motd/motd.erb"),
    require => Package["lsb"],
  }

}
