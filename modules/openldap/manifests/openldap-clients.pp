class openldap::clients {

   $openldapfile = "/etc/openldap/ldap.conf"
   $certfile = "/etc/openldap/cacerts/cacerts.pem"

   case $operatingsystem {
     /(Red Hat|CentOS)/: {
        case $lsbmajdistrelease {
          # This is for CentOS 6.X
          "6": {
             $pamldappackage = "pam_ldap"
             $ldaposfile = "/etc/pam_ldap.conf"

             package { "nss-pam-ldapd":
                 ensure => present,
                 notify => Package["openldap-clients"],
             }

             file { "/etc/nslcd.conf":
                 mode   =>  "644",
                 owner  =>  "root",
                 group  =>  "root",
                 source => "puppet:///modules/openldap/nslcd.conf",
             }

             service { "nslcd":
                 ensure => running,
                 enable => true,
                 hasstatus => true,
                 hasrestart => true,
             }

             # Make home dirs for new users
             exec { "/usr/sbin/authconfig --enablemkhomedir --updateall":
                  require => Package["authconfig"],
             }

           }
           # This should be CentOS 5.X
           default: {

             $pamldappackage = "nss_ldap"
             $ldaposfile = "/etc/ldap.conf"

             package { "nscd": 
                 ensure => present,
                 notify => Package["openldap-clients"],
             }

             service { "nscd":
                 ensure => running,
                 enable => true,
                 hasstatus => true,
                 hasrestart => true,
                 require => [ Package["nscd"], File["/etc/nsswitch.conf"] ],
             }

           }
        }
     }

     default: {
        $ldaposfile = "/etc/ldap.conf" 
     }
   }

   package { "authconfig":
      ensure => present,
   }

   package { "openldap-clients":
      ensure => present,
   }

   package { $pamldappackage:
      ensure => present,
   }

   file { "/etc/nsswitch.conf":
      mode    => "644",
      content => template("openldap/etc/nsswitch.conf.erb"),
   }

   file { $ldaposfile:
      mode    => "644",
      content => template("openldap/etc/ldap.conf.erb"),
   }

   file { $openldapfile:
      mode    => "644",
      content => template("openldap/etc/openldap/ldap.conf.erb"),
   }

   file { $certfile:
      mode    => "600",
      owner   => "root",
      group   => "root",
      source  => "puppet:///modules/openldap/cacert.pem",
   }

   file { "/ahome":
      ensure  => directory,
      mode    => 644,
   }

}

