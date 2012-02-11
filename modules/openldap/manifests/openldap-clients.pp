class openldap::clients {

   package { "openldap-clients":
      ensure => present,
   }

   file { "/etc/ldap.conf":
      ensure => present,
      content => template("openldap/ldap-clients.conf.erb"),
      require => Package("openldap-clients")
   }

}
