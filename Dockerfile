From debian:slim

ENV DEPENDENCIES_SCRIPT=./dependencies.sh
ENV STUDENT_CODE_SCRIPT=./student_code.sh
ENV PLUGIN_ENTRYPOINT=./plugin/plugin.pl
ENV PLUGIN_DIR=./plugin

RUN useradd -u 60001 instructor
RUN useradd -u 60002 student

RUN mkdir -m 700 -p /plugin/instructor_input /plugin/results
RUN chown instructor:instructor /plugin /plugin/instructor_input /plugin/results

RUN mkdir -m 770 -p /plugin/student_input /plugin/work
RUN chown student:instructor /plugin/student_input

VOLUME /plugin/instructor_input /plugin/student_input /plugin/results

COPY --chown instructor:instructor --chmod 700 $PLUGIN_DIR /plugin/
COPY --chown instructor:instructor --chmod 700 $PLUGIN_ENTRYPOINT /plugin/entrypoint
COPY --chown student:instructor --chmod 770 $STUDENT_CODE_SCRIPT /plugin/student_code

RUN apt update && apt install -y \
	sudo
COPY sudo.conf /etc/sudo.conf

COPY $DEPENDENCIES_SCRIPT /tmp/dependencies
RUN /tmp/dependencies && rm /tmp/dependencies


USER instructor

CMD ["entrypoint"]
