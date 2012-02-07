class iptables($ssh_port = 22) {
 
  # This module currently works with CentOS only
  case $lsbmajdistrelease {
        "6": {
          $iptables_template = "iptables/iptables_centos6.erb"
        }
        "5": {
          $iptables_template = "iptables/iptables_centos5.erb"
        }
  }

  package { "iptables":
	ensure => installed
  }

  file { "/etc/sysconfig/iptables" :
	ensure => present,
	recurse => true,
    	mode => 0600,
	owner => "root",
	group => "root",
    	content => template($iptables_template)
  }

  service { "iptables":
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
 	subscribe => File["/etc/sysconfig/iptables"]
  }

}
