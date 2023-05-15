#!/bin/sh
#set -e
export JAVA_OPTS="$JAVA_OPTS \
--add-opens java.base/java.lang=ALL-UNNAMED \
--add-opens java.base/java.lang.reflect=ALL-UNNAMED \
--add-opens java.base/java.util=ALL-UNNAMED \
--add-opens java.base/java.time=ALL-UNNAMED \
-Xloggc:./logs/gc.log \
-XX:+UseCompressedOops \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:+UseG1GC \
-XX:+UnlockExperimentalVMOptions"
export JAVA_PROPS="$JAVA_PROPS -Djava.security.egd=file:/dev/urandom"
exec $(eval echo "$@")
