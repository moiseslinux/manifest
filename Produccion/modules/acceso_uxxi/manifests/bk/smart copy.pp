class _uxxi::smart (
$users = '',
) {
######## AGREGAR GRUPO SUDO ###############################
file_line { 'Grp_sstt':
      ensure => present,
      match   => "%$users ALL=(ALL) ALL",
      multiple => 'false',
      path => '/etc/sudoers',
      line => "%$users ALL=(ALL) ALL",
      
  }  

############## AGRGAR GRUPO SSH ################################

file_line { 'Groups-AD':
        path             => '/etc/ssh/sshd_config',
        match            => 'AllowGroups',
        after            => 'AuthorizedKeysFile',
        line             => "AllowGroups $users",
        replace    => true,
 } 

}