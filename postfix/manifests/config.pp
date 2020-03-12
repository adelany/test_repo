
class postfix::config (
  $smtp_servers
) {
  file { '/etc/postfix/main.cf':
    ensure  => present,
    path    => '/etc/postfix/main.cf',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package[postfix],
    content => template('postfix/main.cf.erb'),
    notify  => Exec['rebuild-main-config'],
  }

  file { '/etc/postfix/master.cf':
    ensure  => present,
    path    => '/etc/postfix/master.cf',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package[postfix],
    source  => ['puppet:///modules/postfix/master.cf'],
    notify  => Exec['reload-postfix'],
  }
}
