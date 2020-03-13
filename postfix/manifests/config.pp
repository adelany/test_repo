
# Config class for Postfix puppet module.
class postfix::config (
  $smtp_servers
) {
  file { '/etc/aliases':
    ensure  => present,
    path    => 'etc/aliases',
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/aliases.erb"),
    notify  => Exec['rebuild-aliases']
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

  if $::postfix_function == 'master' {
    file { '/etc/postfix/main.cf':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package[postfix],
      content => template("${module_name}/master-main.cf.erb"),
      notify  => Exec['rebuild-main-config']
    }

    file { '/etc/postfix/transport':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package[postfix],
      source  => ['puppet:///modules/postfix/transport'],
      notify  => Exec['rebuild-transport']
    }
  }

  elsif $::postfix_function == 'client' {
    file { '/etc/postfix/main.cf':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package[postfix],
      content => template("${module_name}/client-main.cf.erb"),
      notify  => Exec['rebuild-main-config']
    }
  }
}
