# solr

## Overview
This is the solr module. It deploys an instance of [Apache Solr](http://lucene.apache.org/solr/) in to a tomcat servlet environment.

## Module Description

This module obtains the solr war file from [nexus](https://github.com/NERC-CEH/puppet-nexus) and deploys it to a managed tomcat installation.

This module will also deploy jar files to the tomcat installation to enable:

- slf4j - logging
- Java Topology Suite - Spatial Searching

## Setup

### What Solr affects

* Installs and manages a tomcat installation for solr
* Deploys the solr war file

# Usage

To install a instance of solr running on port 7000:

    include solr

Enable spatial searching:

    include solr::jts

Specify a solr home where your solr schema is located:

    class { 'solr' :
        home => '/var/solr',
    }

## Limitations

This module has been tested on Ubuntu 12.04, 14.04 but **should** work on any OS which [puppet-tomcat](https://github.com/NERC-CEH/puppet-tomcat) supports.

## Contributors

Christopher Johnson - cjohn@ceh.ac.uk
