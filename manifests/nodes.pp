# All linux machines
node linuxbase {
   include motd
   include sudo
   include puppet
   include nagios::target
    nagios::service { 'check_ping':
        check_command => 'check_ping!100.0,20%!500.0,60%',
    }
}

node windowsbase {

}

node ubuntu inherits linuxbase {
}

node centos inherits linuxbase {
   include iptables
}

# Basic linjenkins definition
node linjenkins inherits linuxbase {
}

# Puppet Master machine
node 'puppet.eng.snaplogic.com' {
   include motd
   include sudo
   include iptables
   include puppet::master
   include ssh::auth::keymaster
}

# Management machines
node 'adm1.snaplogic.com' inherits linuxbase {
   include nagios::nrpe
   include iptables
}
node 'adm2.snaplogic.com' inherits linuxbase {
   include nagios::nrpe
   include iptables
}

# Monitoring
node 'nagios.eng.snaplogic.com' inherits linuxbase {
   include nagios
   include nagios::defaults
   include nagios::target
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
node 'forge1.snaplogic.com' inherits linuxbase {
   include iptables
}
node 'forge2.snaplogic.com' inherits linuxbase {
   include iptables
}
node 'git.snaplogic.com' inherits linuxbase {
   include iptables
}

# QA Automation machines
node 'qaauto1.eng.snaplogic.com' inherits linuxbase {
}
node 'qaauto2.eng.snaplogic.com' inherits linuxbase {
}
node 'qaauto3.eng.snaplogic.com' inherits windowsbase {
}
node 'qaauto4.eng.snaplogic.com' inherits windowsbase {
}
node 'qaauto5.eng.snaplogic.com' inherits linuxbase {
}
node 'qaauto6.eng.snaplogic.com' inherits linuxbase {
}
node 'qaauto7.eng.snaplogic.com' inherits windowsbase {
}
node 'qaauto8.eng.snaplogic.com' inherits windowsbase {
}

# Jenkins machines
node 'jenkins.int.snaplogic.com' inherits linuxbase {
}
node 'linjenkins1.eng.snaplogic.com' inherits linjenkins {
}
node 'linjenkins2.eng.snaplogic.com' inherits linjenkins {
}
node 'linjenkins3.eng.snaplogic.com' inherits linjenkins {
}
node 'linjenkins4.eng.snaplogic.com' inherits linjenkins {
}
node 'linjenkins5.eng.snaplogic.com' inherits linjenkins {
}
node 'linjenkins6.eng.snaplogic.com' inherits linjenkins {
}

# Build Platform machines
node 'buildmaster.eng.snaplogic.com' inherits linuxbase {
}
node 'build-centos5-32.ec2.internal' inherits linuxbase {
}
node 'build-centos5-64.ec2.internal' inherits linuxbase {
}
node 'build-macos1.compute-1.internal' inherits linuxbase {
}
node 'build-ubuntu-10-10-32.ec2.internal' inherits linuxbase {
}
node 'build-ubuntu-10-10-64.ec2.internal' inherits linuxbase {
}
node 'build-win.ec2.internal' inherits linuxbase {
}

# Build Agent provision machines
node 'build-agent-centos5-32-prov.ec2.internal' inherits linuxbase {
}
node 'build-agent-centos5-64-prov.ec2.internal' inherits linuxbase {
}
node 'build-agent-ubuntu-11-04-64-prov.compute-1.internal' inherits linuxbase {
}
node 'build-agent-ubuntu-11-04-32-prov.ec2.internal' inherits linuxbase {
}
node 'build-win-agent-prov.ec2.internal' inherits linuxbase {
}

# Livetrial production
node 'ltcontroller.snaplogic.com' inherits linuxbase {
}
# Livetrial development
node 'livedev.eng.snaplogic.com' inherits linuxbase {
}
