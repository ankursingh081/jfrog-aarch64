#FROM cpollet/rpi-jre8
FROM aarch64/ubuntu
# To update, check https://bintray.com/jfrog/artifactory/artifactory/view
ENV AF_VERSION=6.9.6 \
		AF_SHA1=0cd6fccab88d484fee2748ea00c7b49323d80e0f \
		AF_HOME=/artifactory
ENV	AF_BASE=artifactory-oss-${AF_VERSION} 
ENV	AF_DL_FILE=artifactory.zip \
		AF_URL=https://bintray.com/jfrog/artifactory/download_file?file_path=jfrog-${AF_BASE}.zip
#AF_URL=https://bintray.com/artifact/download/jfrog/artifactory/jfrog-${AF_BASE}.zip

# Download and extract an artifactory version into the /artifactory directory
# Alter the JVM configuration to use a heap maximum of 512m instead of 2g
RUN apt-get -y update \ 
	&& apt-get install -yqq curl unzip openjdk-8-jdk \
	&& mkdir ${AF_HOME} \
	&& cd ${AF_HOME} \
  && echo ${AF_SHA1} artifactory.zip  > artifactory.zip.sha1 \
  && curl -Lk -o ${AF_DL_FILE} ${AF_URL} \
  && sha1sum -c artifactory.zip.sha1 \
  && unzip -o ${AF_DL_FILE} \
  && mv -f ${AF_BASE}/* . \
  && rm -rf ${AF_DL_FILE} ${AF_BASE} \
  && cd bin \ 
  && sed -ri 's/2g/512m/g' artifactory.default

VOLUME ${AF_HOME}/data
VOLUME ${AF_HOME}/logs
VOLUME ${AF_HOME}/backup

EXPOSE 8081

WORKDIR ${AF_HOME}

CMD bin/artifactory.sh
