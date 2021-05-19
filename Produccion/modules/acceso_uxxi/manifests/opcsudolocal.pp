class acceso_uxxi::opcsudolocal {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
# file_line { 'Grp_XXX':
#      ensure => absent,
#      path => '/etc/sudoers',
#      line => '%supp ALL=(ALL) ALL'
#  }

# AGREGAR GRUPO
  file_line { 'Grp_OPC':
      ensure => present,
      path => '/etc/sudoers',
      line => 'opc ALL=(ALL) NOPASSWD: ALL',
  }

################# GRUPOS SSH ###########################################
#BORRAR GRUPO
  file_line { 'Groups-delssh':
        ensure => absent,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups root sstt prueba_ssh',
        notify          => Service[sshd],
        replace    => true
 }

#AGREGAR GRUPO
  file_line { 'Groups-sshopc':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups opc',
        notify          => Service[sshd],
        replace    => true
 }


}

