

class bash_uxxi {


#  File {
#    owner => $owner,
#    group => $group,
#    mode  => $mode,
#  }
#
#if $facts['os']['name'] == 'Centos' {
#file { '/tmp/banner':
#      ensure  => file,
#      backup  => false,
#      content => template('/etc/puppetlabs/code/environments/prueba/modules/motd/templates/banner.epp'),
# }
#}

file_line { 'Modificar historico':
  path => '/etc/bashrc',
  line => "export HISTTIMEFORMAT='%F %T:  '", 
}

file_line { 'Modificar historico2':
  path => '/etc/bashrc',
  line => "export HISTSIZE=10000",
}

file_line { 'Modificar historico3':
  path => '/etc/bashrc',
  line => "export HISTFILESIZE=10000",
}

}


#class bastionado::ssh {
#
## Gestión de claves públicas de Jacinto Vera
#  ssh_authorized_key { 'ROOT-Jacinto':
#    ensure  => present,
#    user    => 'root',
#    type    => 'ssh-rsa',
#    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC6H9McMKS9R/R9e3I9b06nDIzFjP/TKvAC+Ob7UIxWJcagogTq+ZBF2Kbzkf13RFD3tsH2fs77dfqPvf1UT8aMLMp7c7qpnrIKi0xID7f3tWnp8N/mJ+XsBoX1JRYvW+7UrA0QsRkroLYknfpxY9DLxcKC1cZUHSNRwR2GCuay0Rc4evecoO7aq5S4gAXFYKgwcb0bHeeU8IdYOS4FWkZJtTEPiMc5Aiej8x/vgQmtWVcDxungefiF91Liiq0hr43sucx3Bswr89zCGPZlyKq2Tly4ZTdc6xDlZe/Cubg4OrfeV4UVE5OXPMNWey7WULDW8kEKzlulOhXGSlmncFID',
#    name    => 'jacintovera@CTI-P-010',
#    require => User ['existe_root_user']
#}


#}

