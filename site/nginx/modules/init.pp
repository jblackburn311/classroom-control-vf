class nginx {

  package { 'nginx' :
    ensure => present,
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
    source => 'puppet:///modules/nginx/index.html'
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

  file { '/etc/nginx/conf.d' :
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
