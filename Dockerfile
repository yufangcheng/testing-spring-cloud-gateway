FROM openjdk:17-jdk-alpine

ARG APP_NAME

ENV TZ Asia/Shanghai
ENV JAR_FILE *.jar

ENV USER app
ENV UID 1024
ENV GID 1024

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache tzdata freetype ttf-dejavu fontconfig

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && addgroup -g $GID $USER \
    && adduser -D -G $USER -u $UID $USER

RUN mkdir -p /home/$USER/logs
ADD docker-entrypoint.sh /home/$USER/docker-entrypoint.sh
ADD ${APP_NAME}/target/${JAR_FILE} /home/$USER/
RUN chown -R $USER:$USER /home/$USER/

USER $USER
WORKDIR /home/$USER

EXPOSE 8080

ENTRYPOINT ["sh", "docker-entrypoint.sh"]

CMD ["java","$JAVA_OPTS","$JAVA_PROPS","-jar","$JAR_FILE"]
