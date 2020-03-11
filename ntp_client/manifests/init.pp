class ntp_client () {
      case $facts['os']['name'] {
    /RedHat|CentOS/: {
      contain ntp_client::config
    }
    default: {
      fail('Unsupported OS')
    }
  }
}

