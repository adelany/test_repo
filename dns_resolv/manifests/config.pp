# config class for DNS resolver puppet module.
class dns_resolv::config (
$dns_domain,
$dns_search_path,
$dns_servers
) {

  unless $facts['os']['family'] == 'RedHat' or 'CentOS' {
    fail('This class is only supported on RedHat OS')
  }

  file { '/etc/resolv.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/resolv.conf.erb")
  }

  file_line { 'nsswitch':
    path  => '/etc/nsswitch.conf',
    line  => 'hosts:      files dns',
    match => '^hosts:.*',
  }
}
