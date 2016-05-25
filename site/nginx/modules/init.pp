class nginx {
  file { 'nginx rpm' :
    ensure   => file,
    path     => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    source   => 'puppet:///modules/nginx/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
  }

  package { 'nginx' :
    ensure   => '1.6.2-1.el7.centos.ngx',
    source   => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    provider => rpm,
    require  => File['nginx rpm'],
  }
  
  package { 'nginx' :
    ensure  => present,
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
