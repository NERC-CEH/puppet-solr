# Class solr::jts
#
# This class deploys the jts library to the tomcat which is hosting solr
#
class solr::jts (
  $version = '1.13',
) {
  if ! defined(Class['solr']) {
    fail('You must include the solr base class before you apply jts')
  }

  #Spatial extensions for solr
  tomcat::instance::provide { 'solr/jts':
    tomcat    => 'solr',
    group    => 'com.vividsolutions',
    artifact => 'jts',
    version  => $version,
  }
}
