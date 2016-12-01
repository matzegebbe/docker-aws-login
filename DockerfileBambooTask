FROM python
MAINTAINER Mathias Gebbe <mathias.gebbe@hellmann.net>

RUN pip install awscli --ignore-installed six

ENV aws_access_key_id $YOUR_ACCESS_KEY_ID_HERE
ENV aws_secret_access_key $YOUR_SECRET_ACCESS_KEY_HERE 

RUN mkdir /root/.aws/
RUN printf "[default]\nregion = eu-west-1\n" > /root/.aws/config
RUN printf "[default]\naws_access_key_id = ${aws_access_key_id}\naws_secret_access_key = ${aws_secret_access_key}\n" > /root/.aws/credentials

ENTRYPOINT ["/bin/bash","-c"]
CMD ["aws ecr get-login"]
