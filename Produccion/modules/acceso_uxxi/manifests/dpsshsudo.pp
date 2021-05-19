
class acceso_uxxi::dpsshsudo {

include acceso_uxxi::service
include acceso_uxxi
##################### GRUPOS SUDO ###################################
# BORRAR GRUPO
 file_line { 'Grp_XXX':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%ud-desarrollo ALL=(ALL) NOPASSWD: su - ora12as'
  }  
 file_line { 'Grp_XXX1':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%dp ALL=(ALL) NOPASSWD: su - inside'
  }  
 file_line { 'Grp_XXX2':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%dp ALL=(ALL) NOPASSWD: su - oracle12'
  }  
 file_line { 'Grp_XXX3':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%ud-desarrollo ALL=(ALL) NOPASSWD: su - inside'
  } 
file_line { 'Grp_XXX4':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%ud-desarrollo ALL=(ALL) NOPASSWD: su - oracle12'
  }  

# AGREGAR GRUPO  
  file_line { 'Grp_Dp-ora12as':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%dp ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  
      
  file_line { 'Grp_Dp-inside-del':
      ensure => absent,
      path => '/etc/sudoers',
      line => '%dp ALL=(ALL) NOPASSWD: /bin/su - inside',
  }

  file_line { 'Grp_Dp-oracle12-del':
       ensure => absent,
       path => '/etc/sudoers',
       line => '%dp ALL=(ALL) NOPASSWD: /bin/su - oracle12',
   }
  
  file_line { 'Grp_DP-Consultor-Tecnico-Mantenimiento':
      ensure => present,
      path => '/etc/sudoers',
      line => '%DP-Consultor-Tecnico-Mantenimiento ALL=(ALL) NOPASSWD: /bin/su - ora12as'
  }

  file_line { 'Grp_Dp-inside':
      ensure => present,
      path => '/etc/sudoers',
      line => '%DP-Consultor-Tecnico-Mantenimiento  ALL=(ALL) NOPASSWD: /bin/su - inside',
  }

  file_line { 'Grp_Dp-oracle12':
       ensure => present,
       path => '/etc/sudoers',
       line => '%DP-Consultor-Tecnico-Mantenimiento ALL=(ALL) NOPASSWD: /bin/su - oracle12',
   }

  file_line { 'Grp_DP-Consultor-Tecnico-Implantaciones ':
      ensure => present,
      path => '/etc/sudoers',
      line => '%DP-Consultor-Tecnico-Implantaciones  ALL=(ALL) NOPASSWD: /bin/su - ora12as'
  }

  file_line { 'Grp_DP-Consultor-Tecnico-Implantaciones -inside':
      ensure => present,
      path => '/etc/sudoers',
      line => '%DP-Consultor-Tecnico-Implantaciones   ALL=(ALL) NOPASSWD: /bin/su - inside',
  }

  file_line { 'Grp_DP-Consultor-Tecnico-Implantaciones -oracle12':
       ensure => present,
       path => '/etc/sudoers',
       line => '%DP-Consultor-Tecnico-Implantaciones  ALL=(ALL) NOPASSWD: /bin/su - oracle12',
   }

   file_line { 'Grp_DP-Desarrollo-inside':
      ensure => present,
      path => '/etc/sudoers',
      line => '%DP-Desarrollo   ALL=(ALL) NOPASSWD: /bin/su - inside',
  }

  file_line { 'Grp_DP-Desarrollo-oracle12':
       ensure => present,
       path => '/etc/sudoers',
       line => '%DP-Desarrollo  ALL=(ALL) NOPASSWD: /bin/su - oracle12',
   }

   file_line { 'Grp_ DP-Desarrollo-ora12as':
      ensure => present,
      path => '/etc/sudoers',
      line => '%DP-Desarrollo  ALL=(ALL) NOPASSWD: /bin/su - ora12as'
  }
 ###### Permisos ud-desarrollo 07/04/21

  file_line { 'Grp_Ud-ora12as':
      ensure => present,
      path => '/etc/sudoers',
      line => '%ud-desarrollo ALL=(ALL) NOPASSWD: /bin/su - ora12as',
  }  
      
  file_line { 'Grp_Ud-inside':
      ensure => present,
      path => '/etc/sudoers',
      line => '%ud-desarrollo ALL=(ALL) NOPASSWD: /bin/su - inside',
  }

  file_line { 'Grp_Ud-oracle12':
       ensure => present,
       path => '/etc/sudoers',
       line => '%ud-desarrollo ALL=(ALL) NOPASSWD: /bin/su - oracle12',
   }

################# GRUPOS SSH ###########################################  
 #BORRAR GRUPO 
 # file_line { 'Groups-XXXXXX':
 #       ensure => absent,
 #       path             => '/etc/ssh/sshd_config',
 #       after            => 'AuthorizedKeysFile',
 #       line             => 'AllowGroups prue_sstt',
 #       replace    => true
 #} 

#AGREGAR GRUPO
  file_line { 'Groups-dp':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups DP-Consultor-Tecnico-Mantenimiento DP-Consultor-Tecnico-Implantaciones DP-Desarrollo ora12as oracle12 inside',
        notify          => Service[sshd],
        replace    => true
 } 

 ####### Permisos ud-desarrollo 07/04/21
  file_line { 'Groups-ud':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups ud-desarrollo',
        notify          => Service[sshd],
        replace    => true
 } 

}

