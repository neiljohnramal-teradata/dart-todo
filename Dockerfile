FROM google/dart:1.24

RUN mkdir -p /www/dartapp
WORKDIR /www/dartapp
ADD pubspec.* /www/dartapp/

RUN groupadd -r aqueduct
RUN useradd -m -r -g aqueduct aqueduct
RUN chown -R aqueduct:aqueduct /www/dartapp

USER aqueduct
RUN pub get --no-precompile

USER root
ADD ./lib /www/dartapp/
ADD ./bin /www/dartapp/
ADD ./test /www/dartapp/
ADD *.yml /www/dartapp/
ADD *.yaml /www/dartapp/
RUN chown -R aqueduct:aqueduct /www/dartapp

USER aqueduct
RUN pub get --offline --no-precompile

EXPOSE 8000

ENTRYPOINT ["pub", "run", "aqueduct:aqueduct", "serve", "--port", "8000"]
