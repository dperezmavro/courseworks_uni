#!/bin/bash

if [ ! -d "dev" ] ; then
	mkdir dev ;
fi
cd dev ;

#download and set up tomcat
#this was done for the first part of the coursework
wget -O tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.32/bin/apache-tomcat-6.0.32.tar.gz
tar -xzvf tomcat.tar.gz
wget -O apache-tomcat-6.0.32/webapps/mgrid.war http://www.ecs.soton.ac.uk/~stc/COMP3019/linux-mac-mgrid/mgrid.war
rm tomcat.tar.gz
mkdir -p mgridclient/jars
wget -O mgdk.zip http://www.ecs.soton.ac.uk/~stc/COMP3019/mgrid_dev_kitV1.1.zip
unzip mgdk.zip
rm mgdk.zip

#this sets up the second part of the coursework
wget -O apache-tomcat-6.0.32/webapps/gridsam.war http://www.ecs.soton.ac.uk/~stc/COMP3019/gridsam.war

wget -O gridsamclient.zip http://www.ecs.soton.ac.uk/~stc/COMP3019/gridsam-2.3.0-client.zip
unzip gridsamclient.zip 
rm gridsamclient.zip
cd gridsam-2.3.0-client
java SetupGridSAM

wget -O materials.tgz http://www.ecs.soton.ac.uk/~stc/COMP3019/COMP3019-materials.tgz
gunzip materials.tgz
tar -xvf materials.tar
rm materials.tar

cd ../

wget -O gs-client-doc.zip http://www.ecs.soton.ac.uk/~stc/COMP3019/gridsam-client-apidocs.zip
unzip gs-client-doc.zip
rm gs-client-doc.zip

wget -O gs-core-doc.zip http://www.ecs.soton.ac.uk/~stc/COMP3019/gridsam-core-apidocs.zip
unzip gs-core-doc.zip
rm gs-core-doc.zip