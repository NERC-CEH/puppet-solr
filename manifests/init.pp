# == Class: solr
#
# Deploy a specific version of solr in a tomcat instance
#
# === Parameters
# [*port*]          The port number to run the solr on
# [*version*]       The version number of solr to run
# [*solr_home*]     The location for which solr will read its configuration from
# [*slf4j_version*] Version of slf4j to deploy
# [*log4j_version*] Version of log4j to deploy
# [*jolokia_port*]  The port number to enable jolokia monitoring on
# [*apache_nexus*]  Nexus repository where apache artifacts can be grabbed from
# [*apache_repo*]   The repo in the apache nexus instance to get the artifacts from
# [*central_nexus*] Nexus repository where general artifacts can be grabbed from
# [*central_repo*]  The repo in the general nexus instance to get artifacts from
#
class solr (
  $port          = '7000',
  $version       = '4.6.0',
  $solr_home     = '/home/tomcat7/solr_home',
  $slf4j_version = '1.6.6',
  $log4j_version = '1.2.16',
  $jolokia_port  = undef,
  $apache_nexus  = 'https://repository.apache.org/service/local',
  $apache_repo   = 'public',
  $central_nexus = undef,
  $central_repo  = undef,
) {
  include tomcat

  tomcat::instance { 'solr' :
    http_port         => $port,
    jolokia_port      => $jolokia_port,
    system_properties => {
      'solr.solr.home'  =>  $solr_home
    },
  }

  Tomcat::Deployment {
    nexus => $central_nexus,
    repo  => $central_repo,
  }

  tomcat::deployment { 'Deploy solr':
    tomcat   => 'solr',
    group    => 'org.apache.solr',
    artifact => 'solr',
    version  => $version,
    nexus    => $apache_nexus,
    repo     => $apache_repo,
  }

  tomcat::instance::provide { 'solr/slf4j-api':
    tomcat   => 'solr',
    group    => 'org.slf4j',
    artifact => 'slf4j-api',
    version  => $slf4j_version,
  }

  tomcat::instance::provide { 'solr/slf4j-log4j12':
    tomcat   => 'solr',
    group    => 'org.slf4j',
    artifact => 'slf4j-log4j12',
    version  => $slf4j_version,
  }

  tomcat::instance::provide { 'solr/jcl-over-slf4j':
    tomcat   => 'solr',
    group    => 'org.slf4j',
    artifact => 'jcl-over-slf4j',
    version  => $slf4j_version,
  }

  tomcat::instance::provide { 'solr/jul-to-slf4j':
    tomcat   => 'solr',
    group    => 'org.slf4j',
    artifact => 'jul-to-slf4j',
    version  => $slf4j_version,
  }

  tomcat::instance::provide { 'solr/log4j':
    tomcat   => 'solr',
    group    => 'log4j',
    artifact => 'log4j',
    version  => $log4j_version,
  }
}
