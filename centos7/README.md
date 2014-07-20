build-checkinstall-centos7
==========================

Build a RPM package of the latest version of 'checkinstall' automatically.

Description
-----------

* Base image : centos:centos7
* Image : q1701/build-checkinstall-centos7
* Container : build-checkinstall-centos7
* Output directory : ./share

Scripts
-------

* `build` : Build a image 'q1701/build-checkinstall-centos7'.
* `run` : Create and start a container 'build-checkinstall-centos7.', 
and a RPM file will be created in './share' directory.

Notice
------

* The owner of the created RPM files is 'root'.
