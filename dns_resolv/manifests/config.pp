class dns_resolv::config (
$dns_domain,      
$dns_search_path,
$dns_servers
) {

  unless $facts['os']['family'] == 'RedHat' or 'CentOS' {
    fail('This class is only supported on RedHat OS')
  }

    file { "/etc/resolv.conf":
        owner => root, 
        group => root,
        mode => '644',
        ensure => present,
        content => template("${module_name}/resolv.conf.erb")
    }
    
    file_line { 'nsswitch':
        path  => '/etc/nsswitch.conf',
        line  => "hosts:      files dns",
        match => '^hosts:.*',
    }
}
