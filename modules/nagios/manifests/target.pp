# manifests/target.pp

class nagios::target {

    @@nagios_host { "${fqdn}":
        address => $ec2_public_ipv4 ? {
            "" => $ipaddress,
            default => $ec2_public_ipv4
        },
        alias => $hostname,
        use => 'generic-host',
    }

    if ($nagios_parents != '') {
        Nagios_host["${fqdn}"] { parents => $nagios_parents }
    }

}
