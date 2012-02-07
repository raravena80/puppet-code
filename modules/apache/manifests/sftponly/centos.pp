class apache::sftponly::centos {
  augeas{"add_apache_to_group_sftponly":
    context => "/files/etc/group",
    changes => [ "ins user after sftponly/user[last()]",
      "set sftponly/user[last()]  apache" ],
    onlyif => "match sftponly/*[../user='apache'] size == 0",
    require => Package['apache'],
    notify =>  Service['apache'],
  }
}
