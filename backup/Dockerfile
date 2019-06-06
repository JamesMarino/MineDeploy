FROM alpine:3.9

ENV INSTANCE_NAME mine-deploy-instance
ENV S3_BUCKET_NAME mine-deploy-backup-bucket

COPY src/run.sh /root/scripts/run.sh

RUN apk update
RUN apk add python3 zip
RUN pip3 install awscli --upgrade

RUN export PATH=/root/.local/bin:$PATH
RUN chmod +x /root/scripts/run.sh

CMD /root/scripts/run.sh
