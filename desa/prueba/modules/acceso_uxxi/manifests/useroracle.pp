
class acceso_uxxi::useroracle {

include acceso_uxxi::service
include acceso_uxxi
      
#################  SSH ###########################################  
file_line { 'user.oracle':
   path => '/etc/ssh/sshd_config',
   line => 'Match User oracle12',
}

file_line { 'user-oracle':
   path => '/etc/ssh/sshd_config',
   line =>  '    AllowUsers oracle12@sstt010-backup.ocuarsys',
   notify          => Service[sshd],

}

file_line { 'user-oracle1':
   path => '/etc/ssh/sshd_config',
   ensure   => present,
   after =>  '^Match User oracle12',
   line =>  '    AllowUsers oracle12@H16124.ocuarsys',
   notify          => Service[sshd],

}
############
file_line { 'user.oraclei11':
   path => '/etc/ssh/sshd_config',
   line => 'Match User oracle11',
}

file_line { 'user-oracle2':
   path => '/etc/ssh/sshd_config',
   line =>  '    AllowUsers oracle11@sstt010-backup.ocuarsys',
   notify          => Service[sshd],

}

file_line { 'user-oracle3':
   path => '/etc/ssh/sshd_config',
   ensure   => present,
   after =>  '^Match User oracle11',
   line =>  '    AllowUsers oracle11@H16124.ocuarsys',
   notify          => Service[sshd],

}



#AGREGAR GRUPO
  file_line { 'Groups-dba':
        ensure => present,
        path             => '/etc/ssh/sshd_config',
        after            => 'AuthorizedKeysFile',
        line             => 'AllowGroups dba11 dba12 dba ',
        notify            => Service[sshd],
        replace    => true
 }


}

