class motd_arsys::service {

  service { 'smb':
       ensure  => 'running',
       enable  => true,
      #subscribe => File['/etc/ssh/sshd_config'],
    }

  service { 'nmb':
       ensure  => 'running',
       enable  => true,
      #subscribe => File['/etc/ssh/sshd_config'],
    }

  service { 'winbind':
       ensure  => 'running',
       enable  => true,
      #subscribe => File['/etc/ssh/sshd_config'],
    }

  service { 'sshd':
       ensure  => 'running',
       enable  => true,
      #subscribe => File['/etc/ssh/sshd_config'],
    }


}

