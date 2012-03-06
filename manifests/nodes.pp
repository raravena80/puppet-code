# All linux machines
node linuxbase {
   include motd
   include sudo
   include puppet
}

node windowsbase {

}

node ubuntu inherits linuxbase {
   include ufw
   ufw::rules { "ubuntu": }
   $my_nagios_hostgroups = "debian-servers"
   include nagios::target
   include nagios::nrpe
   nagios::service { 'check_ping':
       check_command => 'check_ping!100.0,20%!500.0,60%',
   }
}

node centos inherits linuxbase {
   include iptables
   $my_nagios_hostgroups = "centos-servers"
   include nagios::target
   include nagios::nrpe
   nagios::service { 'check_ping':
       check_command => 'check_ping!100.0,20%!500.0,60%',
   }
   nagios::service { 'check_load':
       check_command => 'check_nrpe!check_load',
   }
   nagios::service { 'check_zombie_procs':
       check_command => 'check_nrpe!check_zombie_procs',
   }
   nagios::service { 'check_total_procs':
       check_command => 'check_nrpe!check_total_procs',
   }
}

node awsubuntu inherits linuxbase {
   $my_nagios_hostgroups = "debian-servers"
   include nagios::target
   nagios::service { 'check_ping':
       check_command => 'check_ping!100.0,20%!500.0,60%',
   }

}

node awscentos inherits linuxbase {
   $my_nagios_hostgroups = "centos-servers"
   include nagios::target
   include nagios::nrpe
   nagios::service { 'check_ping':
       check_command => 'check_ping!100.0,20%!500.0,60%',
   }

}

# Basic linjenkins definition
node linjenkins inherits linuxbase {
}

# Puppet Master machine
node 'puppet.eng.snaplogic.com' {
   include motd
   include sudo
   include iptables
   include openldap::clients
   include puppet::master
   #include ssh::auth::keymaster
}

# Management machines
node 'adm1.snaplogic.com' inherits centos {
   nagios::service { 'check_users':
       check_command => 'check_nrpe!check_users',
   }
}
node 'adm2.snaplogic.com' inherits centos {
   nagios::service { 'check_users':
       check_command => 'check_nrpe!check_users',
   }
}

# Monitoring
node 'nagios.eng.snaplogic.com' inherits linuxbase {
   include iptables
   $my_nagios_hostgroups = "centos-servers"
   include nagios
   include nagios::defaults
   include nagios::target
   nagios::service { 'check_ping':
       check_command => 'check_ping!100.0,20%!500.0,60%',
   }
#   include nagios::apache
#   include nagios::defaults
	# Declare another nagios command
#	nagios::command { 
#          http_port: 
#            command_line => '/usr/lib64/nagios/plugins/check_http -p $ARG1$ -H $HOSTADDRESS$ -I $HOSTADDRESS$'
#        }

    nagios::service { 'check_http':
        check_command => 'http_port!80',
    }

}

# Source code control machines
node 'forge1.snaplogic.com' inherits centos {
}
node 'forge2.snaplogic.com' inherits centos {
}
node 'git.snaplogic.com' inherits centos {
}

# QA Automation machines
node 'qaauto1.eng.snaplogic.com' inherits centos {
}
node 'qaauto2.eng.snaplogic.com' inherits ubuntu {
   include openldap::clients::debian
}
node 'qaauto3.eng.snaplogic.com' inherits windowsbase {
}
node 'qaauto4.eng.snaplogic.com' inherits windowsbase {
}
node 'qaauto5.eng.snaplogic.com' inherits centos {
}
node 'qaauto6.eng.snaplogic.com' inherits ubuntu {
}
node 'qaauto7.eng.snaplogic.com' inherits windowsbase {
}
node 'qaauto8.eng.snaplogic.com' inherits windowsbase {
}

# Jenkins machines
node 'jenkins.int.snaplogic.com' inherits centos {
}
node 'linjenkins1.eng.snaplogic.com' inherits ubuntu {
}
node 'linjenkins2.eng.snaplogic.com' inherits ubuntu {
}
node 'linjenkins3.eng.snaplogic.com' inherits ubuntu {
}
node 'linjenkins4.eng.snaplogic.com' inherits ubuntu {
}
node 'linjenkins5.eng.snaplogic.com' inherits ubuntu {
}
node 'linjenkins6.eng.snaplogic.com' inherits ubuntu {
}

# Build Platform machines
node 'buildmaster.eng.snaplogic.com' inherits awscentos {
}
node 'build-centos5-32.ec2.internal' inherits awscentos {
}
node 'build-centos5-64.ec2.internal' inherits awscentos {
}
node 'build-macos1.compute-1.internal' inherits awscentos {
}
node 'build-ubuntu-10-10-32.ec2.internal' inherits awsubuntu {
}
node 'build-ubuntu-10-10-64.ec2.internal' inherits awsubuntu {
}
node 'build-win.ec2.internal' inherits awscentos {
}

# Build Agent provision machines
node 'build-agent-centos5-32-prov.ec2.internal' inherits awscentos {
}
node 'build-agent-centos5-64-prov.ec2.internal' inherits awscentos {
}
node 'build-agent-ubuntu-11-04-64-prov.compute-1.internal' inherits awsubuntu {
}
node 'build-agent-ubuntu-11-04-32-prov.ec2.internal' inherits awsubuntu {
}
node 'build-win-agent-prov.ec2.internal' inherits awscentos {
}

# Livetrial production
node 'ltcontroller.snaplogic.com' inherits centos {
}
# Livetrial development
node 'livedev.eng.snaplogic.com' inherits centos {
}

# HA proxy
node 'haproxy.eng.snaplogic.com' inherits centos {
   include haproxy
}
