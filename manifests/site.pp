import "templates"
import "nodes"
import "modules"

$puppetserver = 'puppet.eng.snaplogic.com'

Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}
