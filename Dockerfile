FROM alpine:latest

ARG BUILD_DATE

ARG VERSION

ARG VCS_REF

ARG FIREBASE_TOOLS_VERSION


LABEL org.label-schema.schema-version="1.0" \
	org.label-schema.name="42devs/image-firebase" \
	org.label-schema.version=${VERSION} \
	org.label-schema.build-date=${BUILD_DATE} \
	org.label-schema.description="NodeJS image with Firebase CLI and emulators" \
	org.label-schema.url="https://github.com/firebase/firebase-tools" \
	org.label-schema.vcs-url="https://github.com/42devs/image-firebase" \
	org.label-schema.vcs-ref=${VCS_REF}

ENV HOME=/opt/node

EXPOSE 9099 5001 8080 3000 9199 8085 4000 4500 4400

RUN apk add --no-cache openjdk17-jre \
	bash \
	nodejs \
	yarn \
	npm \
	curl \
	zip && \
	yarn global add firebase-tools@${FIREBASE_TOOLS_VERSION} && \
	yarn cache clean && \
	firebase setup:emulators:firestore && \
	firebase setup:emulators:database && \
	firebase setup:emulators:pubsub && \
	firebase setup:emulators:storage && \
	firebase -V && \
	java --version && \
	echo "0.0.0.0 	localhost" > /etc/hosts

VOLUME $HOME/.cache

WORKDIR $HOME

CMD bash