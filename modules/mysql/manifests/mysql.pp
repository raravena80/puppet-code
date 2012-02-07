class mysql {
  package { "mysql-server":
	ensure => installed
  }

  service { "mysql":
        name => $operatingsystem ? {
	  /(Fedora|Red Hat|CentOS)/ => "mysqld",
          /(Ubuntu|Debian)/ => "mysql"
        },
        ensure => running,
  }

}
