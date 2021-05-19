
class resolv_uxxi {

#### resolv ARSYS
if $facts['networking']['network'] == '172.23.0.0' {
file { '/etc/resolv.conf':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/resolv/ARSYS.epp'),
    }
}
if $facts['networking']['network'] == '172.21.0.0' {
file { '/etc/resolv.conf':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/resolv/ARSYS.epp'),
    }
}

#### resolv UXXI_SEDE
if $facts['networking']['network'] == '172.16.0.0' {
file { '/etc/resolv.conf':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/resolv/UXXI.epp'),
    }
}
if $facts['networking']['network'] == '172.29.0.0' {
file { '/etc/resolv.conf':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/resolv/UXXI.epp'),
    }
}

#### resolv AWS
if $facts['networking']['network'] == '172.30.0.0' {
file { '/etc/resolv.conf':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/resolv/AWS.epp'),
    }
}
if $facts['networking']['network'] == '172.31.0.0' {
file { '/etc/resolv.conf':
      ensure  => file,
      backup  => false,
      content => template('/etc/puppetlabs/code/environments/CONF/resolv/AWS.epp'),
    }
}

}





