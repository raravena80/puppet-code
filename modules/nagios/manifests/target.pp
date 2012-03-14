# manifests/target.pp

class nagios::target {

    @@nagios_host { "${fqdn}":
        address => $ec2_public_ipv4 ? {
            "" => $ipaddress,
            default => $ec2_public_ipv4
        },
        alias => $hostname,
        use => 'generic-host',
        hostgroups => inline_template("<%= has_variable?('my_nagios_hostgroups') ? my_nagios_hostgroups : 'Others' %>"),

    }

#    notify { "Im here $my_nagios_hostgroups":}

    if ($nagios_parents != '') {
        Nagios_host["${fqdn}"] { parents => $nagios_parents }
    }

}
