FROM centos:centos6

MAINTAINER q1701 <q1701@outlook.com>

# Update yum packages.
RUN yum -y update

# Create a working directory.
RUN mkdir /tmp/build
ENV BUILD_TMP /tmp/build
WORKDIR /tmp/build

## place scripts
ADD scripts/build_rpm.sh $BUILD_TMP/build_rpm.sh

# Export the generated rpm file.
CMD ["/bin/bash", "-c", "$BUILD_TMP/build_rpm.sh"]
