class openldap::clients::debian {

   $openldapfile = "/etc/ldap/ldap.conf"
   $certfile = "/etc/ldap/cacerts/cacerts.pem"

   package { "auth-client-config": ensure => present }
   package { "ldap-auth-client": ensure => present }
   package { "ldap-auth-config": ensure => present }
   package { "libnss-db": ensure => present }
   package { "libnss-ldap": ensure => present }
   package { "libpam-ldap": ensure => present }
   package { "nscd": ensure => present }
   package { "nss-updatedb": ensure => present }
   package { "ldap-utils": ensure => present }


#   file { "/etc/nsswitch.conf":
#      mode    => "644",
#      content => template("openldap/etc/nsswitch.conf.erb"),
#   }

#   file { $ldaposfile:
#      mode    => "644",
#      content => template("openldap/etc/ldap.conf.erb"),
#   }

#   file { $openldapfile:
#      mode    => "644",
#      content => template("openldap/etc/openldap/ldap.conf.erb"),
#   }

#   file { $certfile:
#      mode    => "600",
#      owner   => "root",
#      group   => "root",
#      source  => "puppet:///modules/openldap/cacert.pem",
#   }

   file { "/ahome":
      ensure  => directory,
      mode    => 644,
   }

}

