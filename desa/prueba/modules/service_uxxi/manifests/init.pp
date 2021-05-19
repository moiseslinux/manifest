class service_uxxi {


include acceso_uxxi::service


file { "/tmp/foo": ensure => present }

notify => Service[sshd],
if defined(File["/etc/samba/smb.conf"]) {
  alert("/etc/samba/smb.conf is defined")
} else {
  alert("/tmp/foo is not defined")
  #notify{"Service[sshd]":}
}
  


}



