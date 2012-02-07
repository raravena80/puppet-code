# http://hostby.net/home/2008/07/12/centos-5-and-mpm-itk/
class apache::centos::itk_plus inherits apache::centos::itk {
  Exec['adjust_pidfile']{
    command => "/bin/sed -i  's/^PidFile \(.*\)/#PidFile \1/g' /etc/httpd/conf/httpd.conf",
    unless => "/bin/grep -qE '^#PidFile ' /etc/httpd/conf/httpd.conf",
  }
  Exec['adjust_listen']{
    command => "/bin/sed -i  's/^Listen 80/#Listen 80/g' /etc/httpd/conf/httpd.conf",
    unless => "/bin/grep -qE '^#Listen 80' /etc/httpd/conf/httpd.conf",
  }

  Apache::Config::Global['00-listen.conf']{
    ensure => 'present',
    content => template("apache/itk_plus/${operatingsystem}/00-listen.conf.erb"),
  }

  File['apache_service_config']{
    source => "puppet:///modules/apache/service/CentOS/httpd.itk_plus"
  }
}
