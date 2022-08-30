FROM alpine:latest

ENV FIREBASE_TOOLS_VERSION=10.9.2

WORKDIR /var/app

RUN apk add --no-cache openjdk17-jdk nodejs yarn npm curl zip python3 py3-pip && rm -fr /var/cache/apk/*

RUN yarn global add firebase-tools@${FIREBASE_TOOLS_VERSION}

RUN echo "0.0.0.0   localhost" >> /tmp/hosts

EXPOSE 9099 5001 8080 3000 9199 8085 4000 4500 4400
