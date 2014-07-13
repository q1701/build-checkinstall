centos-build-checkinstall
=========================

Build a RPM package of the latest version of 'checkinstall' automatically.

Description
-----------

* Base image : centos:centos6
* Image : q1701/centos-build-checkinstall
* Container : centos-build-checkinstall
* Output directory : ./share

Scripts
-------

* `build` : Build a image 'q1701/centos-build-checkinstall'.
* `run` : Create and start a container 'centos-build-checkinstall.', 
and a RPM file will be created in './out' directory.

Notice
------

* The owner of the created RPM files is 'root'.
