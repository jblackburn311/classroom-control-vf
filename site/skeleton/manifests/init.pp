class skeleton {
  file { '/etc/skel' :
    ensure => directory,
  }
  
  file { '/etc/skel/.bashrc' :
    ensure => file,
    group => 'root',
    owner =>
    mode => '0644',
    source => 'puppet:///modules/skeleton/bashrc',
  }
}
  
