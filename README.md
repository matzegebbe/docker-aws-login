# docker-aws-login

this docker aws-cli is used to preform an aws login so you are able to push & pull images

for example we have this task in an build-plan:

you have to set your AWS credentials and region (eu-west-1)

### preform a login with the container

YOUR_ACCESS_KEY YOUR_SECRET_ACCESS_KEY REGION+

```bash
$(docker run --rm matzeihn/docker-aws-login "AFDGJSKADFKALSDFJASKDLF" "45345/fdfaADSFIJLKSDFASD" "eu-west-1")
```

### bamboo task example (including a docker build if image does not exist)

```bash
#!/bin/bash

docker images hellmann/awscli | grep -q awscli
[ "$?" -eq "0" ] && exit 0

cat <<'EOF' >> Dockerfile
FROM python
MAINTAINER Mathias Gebbe <mathias.gebbe@hellmann.net>

RUN pip install awscli --ignore-installed six

ENV aws_access_key_id AWS_ACCESS_KEY
ENV aws_secret_access_key AWS_SECRET_ACCESS_KEY 

RUN mkdir /root/.aws/
RUN printf "[default]\nregion = eu-west-1\n" > /root/.aws/config
RUN printf "[default]\naws_access_key_id = ${aws_access_key_id}\naws_secret_access_key = ${aws_secret_access_key}\n" > /root/.aws/credentials

ENTRYPOINT ["/bin/bash","-c"]
CMD ["aws ecr get-login"]
EOF

docker build -t hellmann/awscli .
$(docker run --rm hellmann/awscli)
```
