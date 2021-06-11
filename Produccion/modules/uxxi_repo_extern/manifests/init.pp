class uxxi_repo_extern {


file { '/etc/yum.repos.d/repo-externo.repo':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content =>  template('/etc/puppetlabs/code/environments/Arsys/modules/uxxi_repo_extern/templates/roles/Repository/repo-externo.repo'),
   }
}
