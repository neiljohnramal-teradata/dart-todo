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
ADD . /www/dartapp/
RUN chown -R aqueduct:aqueduct /www/dartapp

USER aqueduct
RUN pub get --offline --no-precompile

EXPOSE 8000

CMD ["./entrypoint.sh"]
