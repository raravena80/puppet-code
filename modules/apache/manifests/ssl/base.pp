class apache::ssl::base {
    ::apache::config::include{ 'ssl_defaults.inc': }
    ::apache::vhost::file{ '0-default_ssl': }
}
