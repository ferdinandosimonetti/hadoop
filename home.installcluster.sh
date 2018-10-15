#!/bin/bash -x
# Ambari host
export AMBARISRVHOST="l01.lan"
# Ambari cluster
export CLUSTERNAME="home"
export BPNAME="home2"
export CURLCMD="curl -k -u admin:admin -i"
export BASEURL="http://${AMBARISRVHOST}:8080/api/v1"
export BASECLU="${BASEURL}/clusters/${CLUSTERNAME}"
export BASEVDF="${BASEURL}/version_definitions"
export BASEBP="${BASEURL}/blueprints"

# add Hadoop version local repository to Ambari
${CURLCMD} -H "X-Requested-By:ambari" -X POST ${BASEVDF} -d @${BPNAME}.version-definitions.json
# add blueprint information to Ambari
${CURLCMD} -H "X-Requested-By:ambari" -X POST ${BASEBP}/${BPNAME} -d @${BPNAME}.cluster-config.json
# apply blueprint to host topology
${CURLCMD} -H "X-Requested-By:ambari" -X POST ${BASECLU} -d @${BPNAME}.host-mapping.json
