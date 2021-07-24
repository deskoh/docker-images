#!/bin/bash -e

configured_file="/opt/configured"
if [ ! -e "$configured_file" ]; then
  touch "$configured_file"
  /opt/tools/x509.sh
fi

# Check if command exists
if command -v $1 >& /dev/null; then
  exec "$@"
fi

# Optional: Run jar / class files with args forwarding
# exec java ${JAVA_OPTS} -jar /app.jar $@
# exec java ${JAVA_OPTS} -cp app:app/lib/* hello.Application $@
