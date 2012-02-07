class sudo {

    package { sudo: ensure => latest }

    file { "/etc/sudoers":
        owner   => root,
        group   => root,
        mode    => 440,
	source  => "puppet://$puppetserver/modules/sudo/etc/sudoers",
	require => Package["sudo"],
    }
}

