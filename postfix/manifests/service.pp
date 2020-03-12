class postfix::service () {
  service { 'postfix':
    enable => true,
    ensure => running,
    require => Package[postfix],
  }

  exec { 'reload-postfix':
    command => '/etc/init.d/postfix reload',
    refreshonly => true,
  }

  exec { 'rebuild-main-config':
    command => "/usr/sbin/postmap /etc/postfix/main.cf",
    refreshonly => true,
  }
}
