function autogenerate_keystores() {
  # Update truststore if X509_CA_BUNDLE was provided
  local -r X509_CRT_DELIMITER="/-----BEGIN CERTIFICATE-----/"
  local TEMPORARY_CERTIFICATE="temporary_ca.crt"
  if [ -n "${X509_CA_BUNDLE}" ]; then
    pushd /tmp >& /dev/null
    echo "Updating truststore..."

    # We use cat here, so that users could specify multiple CA Bundles using space or even wildcard:
    # X509_CA_BUNDLE=/var/run/secrets/kubernetes.io/serviceaccount/*.crt
    # Note, that there is no quotes here, that's intentional. One can use spaces in the $X509_CA_BUNDLE like this:
    # X509_CA_BUNDLE=/ca.crt /ca2.crt
    cat ${X509_CA_BUNDLE} > ${TEMPORARY_CERTIFICATE}
    csplit -s -z -f crt- "${TEMPORARY_CERTIFICATE}" "${X509_CRT_DELIMITER}" '{*}'
    for CERT_FILE in crt-*; do
      keytool -importcert -noprompt -file "${CERT_FILE}" -trustcacerts -cacerts \
      -storepass changeit -alias "service-${CERT_FILE}" 2> /dev/null
    done

    popd >& /dev/null
  fi
}

autogenerate_keystores
