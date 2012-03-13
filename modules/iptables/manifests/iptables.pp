class iptables($ssh_port = 22) {

  #iptables::ipaddresses { "iptables": }

  $allowaddrs = [['12.90.36.218', 'SnapLogics Gateway'],
                ['50.56.216.101', 'jenkins.int.snaplogic.com'],
                ['10.8.8.0/24', 'SnapLogics VPN Network'],
                ['174.129.212.180', 'buildmaster.eng.snaplogic.com'],
                ['209.114.36.218', 'linjenkins1'],
                ['174.143.143.183', 'linjenkins2'],
                ['173.203.237.224', 'linjenkins3'],
                ['174.143.142.218', 'linjenkins4'],
                ['174.143.143.168', 'linjenkins5'],
                ['50.56.233.39', 'linjenkins6'],
                ['184.106.229.119', 'adm1 External'],
                ['184.106.229.120', 'adm2 External'],
                ['10.179.122.33', 'adm1 Internal'],
                ['10.179.122.34', 'adm2 Internal'],
                ['99.6.132.0/22', 'Ricardos Home'],
                ['24.7.21.9', 'Martins Home'],
                ['50.57.74.121', 'puppet.eng.snaplogic.com'],
                ['50.57.45.152', 'nagios.eng.snaplogic.com'],
                ['91.213.92.3', 'Lohikas Gateway'],
                ['50.57.154.17', 'qaauto1.eng.snaplogic.com'],
                ['50.57.153.77', 'qaauto2.eng.snaplogic.com'],
                ['50.57.229.120', 'qaauto3.eng.snaplogic.com'],
                ['50.57.229.165', 'qaauto4.eng.snaplogic.com'],
                ['50.57.220.27', 'qaauto5.eng.snaplogic.com'],
                ['50.57.226.252', 'qaauto6.eng.snaplogic.com'],
                ['50.57.220.251', 'qaauto7.eng.snaplogic.com'],
                ['50.57.220.20', 'qaauto8.eng.snaplogic.com'],
                ['50.57.105.22', 'ltcontroller.snaplogic.com'],
                ['209.114.38.148', 'livedev.eng.snaplogic.com'],
                ['174.143.142.103', 'forge1.snaplogic.com'],
                ['173.203.237.144', 'forge2.snaplogic.com'],
                ['76.126.244.86', 'Shashis Home'],
                ['108.85.45.125', 'Dhirajs Home'],
                ['24.7.60.83', 'Tims Home'],
                ['69.42.5.8', 'Jims Home'],
                ['24.5.183.161', 'Dianes Home'],
                ['24.7.17.3', 'Dreas Home'],
                ['108.166.109.208', 'testy.eng.snaplogic.com'],
                ['50.57.180.161', 'shailesh1'],
                ['173.203.224.158', 'shailesh2'],
                ['88.211.43.162', 'UK Office']]

 
  # This module currently works with CentOS only
  if ( $fqdn == "ltcontroller.snaplogic.com" ) {
        $iptables_template = "iptables/iptables_web.erb"
  }
  else {
    case $lsbmajdistrelease {
          "6": {
            $iptables_template = "iptables/iptables_centos.erb"
          }
          "5": {
            $iptables_template = "iptables/iptables_centos.erb"
          }
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
