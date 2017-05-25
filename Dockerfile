FROM fixate/mongotools-alpine

# Install aws cli
RUN apk --no-cache add bash py-pip python && \
    pip install --upgrade pip awscli

ADD backup.sh /backup.sh
CMD /backup.sh
