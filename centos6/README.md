build-checkinstall-centos6
==========================

Build a RPM package of the latest version of 'checkinstall' automatically.

Description
-----------

* Base image : centos:centos6
* Image : q1701/build-checkinstall-centos6
* Container : build-checkinstall-centos6
* Output directory : ./share

Scripts
-------

* `build` : Build a image 'q1701/build-checkinstall-centos6'.
* `run` : Create and start a container 'build-checkinstall-centos6.', 
and a RPM file will be created in './share' directory.

Notice
------

* The owner of the created RPM files is 'root'.
