class nginx {
  yumrepo { 'base':
    ensure              => 'present',
    descr               => 'CentOS-$releasever - Base',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra',
    priority            => '99',
    skip_if_unavailable => '1',
  }
  
  yumrepo { 'updates':
    ensure              => 'present',
    descr               => 'CentOS-$releasever - Updates',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra',
    priority            => '99',
    skip_if_unavailable => '1',
  }
  
  yumrepo { 'extras':
    ensure              => 'present',
    descr               => 'CentOS-$releasever - Extras',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra',
    priority            => '99',
    skip_if_unavailable => '1',
  }
  
  yumrepo { 'centosplus':
    ensure     => 'present',
    descr      => 'CentOS-$releasever - Plus',
    enabled    => '1',
    gpgcheck   => '1',
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra',
  }
  
  package { 'nginx' :
    ensure  => present,
    require => Yumrepo['base'],
  }

  file { '/var/www' :
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  
  file { 'index.html' :
    ensure => file,
    path => '/var/www/index.html',
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'nginx.conf' :
    ensure => file,
    path => '/etc/nginx/nginx.conf',
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  file { '/etc/nginx/default.d' :
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  
  file { 'default.conf' :
    ensure => file,
    path => '/etc/nginx/conf.d/default.conf',
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet://modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  
  service { 'nginx' :
    ensure => running,
    enable => true,
  }
    
}
