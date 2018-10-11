#!/bin/bash -x
# Ambari host
export AMBARISRVHOST="lcsgepalsv058.lcs.priv"
# Hive server host
export HIVESRVHOST="lcsgepalsv064.lcs.priv"
# Hive metastore host
export HIVEMSHOST="lcsgepalsv065.lcs.priv"
# Ambari cluster
export CLUSTERNAME="misdev"
export BPNAME="ha-hdfs-yarn"
export CURLCMD="curl -k -u admin:admin -i"
export BASEURL="http://${AMBARISRVHOST}:8080/api/v1"
export BASECLU="${BASEURL}/clusters/${CLUSTERNAME}"
export BASEVDF="${BASEURL}/version_definitions"
export BASEBP="${BASEURL}/blueprints"

# add Hadoop version local repository to Ambari
${CURLCMD} -H "X-Requested-By:ambari" -X POST ${BASEVDF} -d @version-definitions.json
# add blueprint information to Ambari
${CURLCMD} -H "X-Requested-By:ambari" -X POST ${BASEBP}/${BPNAME} -d @${BPNAME}.cluster-config.json
# apply blueprint to host topology
${CURLCMD} -H "X-Requested-By:ambari" -X POST ${BASECLU} -d @${BPNAME}.host-mapping.json
