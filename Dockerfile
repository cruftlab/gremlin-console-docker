FROM openjdk:8-jre

# Set Gremlin Console version and URLs
ENV GREMLIN_VERSION 3.3.3
# ENV GREMLIN_ZIP_URL https://www.apache.org/dyn/closer.lua/tinkerpop/$GREMLIN_VERSION/apache-tinkerpop-gremlin-console-$GREMLIN_VERSION-bin.zip
# SHA-1 doesn't seem to match when downloading from the above site...
ENV GREMLIN_ZIP_URL https://www-eu.apache.org/dist/tinkerpop/$GREMLIN_VERSION/apache-tinkerpop-gremlin-console-$GREMLIN_VERSION-bin.zip
ENV GREMLIN_SHA1_URL "$GREMLIN_ZIP_URL".sha1

# Download, verify and extract Gremlin Console archive
RUN cd /opt && \
    echo "Downloading Gremlin Console zip..." && \
	wget --quiet -O gremlin-console.zip "$GREMLIN_ZIP_URL" && \
    echo "Downloading Gremlin Console zip SHA-1..." && \
	wget --quiet -O expected.sha1 "$GREMLIN_SHA1_URL" && \
	echo "Verifying signature..." && \
	sha1sum gremlin-console.zip > actual.sha1 && \
	grep -F -f expected.sha1 actual.sha1 && \
	echo "Extracting archive..." && \
    unzip gremlin-console.zip && \
    ln -s apache-tinkerpop-gremlin-console-$GREMLIN_VERSION gremlin && \
	echo "Cleaning up..." && \
    rm gremlin-console.zip *.sha1

# Mount configuration and data directory
VOLUME /opt/gremlin/conf/extra /opt/gremlin/data

WORKDIR /opt/gremlin

ENTRYPOINT ["./bin/gremlin.sh"]
