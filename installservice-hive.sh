#!/bin/bash -x
# Ambari host
export AMBARISRVHOST="lcsgepalsv058.lcs.priv"
# Hive server host
export HIVESRVHOST="lcsgepalsv064.lcs.priv"
# Hive metastore host
export HIVEMSHOST="lcsgepalsv065.lcs.priv"
# Ambari cluster
export CLUSTERNAME="misdev"
export CURLCMD="curl -k -u admin:admin -i"
export BASEURL="http://${AMBARISRVHOST}:8080/api/v1"
export BASECLU="${BASEURL}/clusters/${CLUSTERNAME}"
# add services to cluster
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"ServiceInfo":{"service_name":"HIVE"}}' "${BASECLU}/services"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"ServiceInfo":{"service_name":"TEZ"}}' "${BASECLU}/services"
# confirm services
${CURLCMD} -H "X-Requested-By:ambari" -X GET "${BASECLU}/services/HIVE"
${CURLCMD} -H "X-Requested-By:ambari" -X GET "${BASECLU}/services/TEZ"
# add service components to cluster
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE SERVER"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASECLU}/services/HIVE/components/HIVE_SERVER"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE INTERACTIVE"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASECLU}/services/HIVE/components/HIVE_SERVER_INTERACTIVE"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE METASTORE"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASECLU}/services/HIVE/components/HIVE_METASTORE"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE CLIENT"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASECLU}/services/HIVE/components/HIVE_CLIENT"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install TEZ CLIENT"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASECLU}/services/TEZ/components/TEZ_CLIENT"
# load INITIAL service configurations
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@tez-env-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@tez-site-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@tez-interactive-site-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-env-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-site-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hivemetastore-site-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-interactive-env-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-interactive-site-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hiveserver2-site-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hiveserver2-interactive-site-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@llap-daemon-log4j-INITIAL.json' "${BASECLU}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@llap-cli-log4j2-INITIAL.json' "${BASECLU}/configurations"
# apply service configurations
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "tez-env", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "tez-site", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "tez-interactive-site", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-env", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-site", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hivemetastore-site", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-interactive-env", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-interactive-site", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hiveserver2-site", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hiveserver2-interactive-site", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "llap-daemon-log4j", "tag" : "INITIAL" }}}' ${BASECLU}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "llap-cli-log4j2", "tag" : "INITIAL" }}}' ${BASECLU}
# create "server" host components
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_SERVER"}}] }' "${BASECLU}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_SERVER_INTERACTIVE"}}] }' "${BASECLU}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_METASTORE"}}] }' "${BASECLU}/hosts?Hosts/host_name=${HIVEMSHOST}"
# create "client" host components 
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_CLIENT"}}] }' "${BASECLU}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_CLIENT"}}] }' "${BASECLU}/hosts?Hosts/host_name=${HIVEMSHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"TEZ_CLIENT"}}] }' "${BASECLU}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"TEZ_CLIENT"}}] }' "${BASECLU}/hosts?Hosts/host_name=${HIVEMSHOST}"
# install the services
${CURLCMD} -H "X-Requested-By:ambari" -X PUT -d '{"RequestInfo":{"context":"Install TEZ via REST API"}, "ServiceInfo": {"state" : "INSTALLED"}}' "${BASECLU}/services/TEZ"
${CURLCMD} -H "X-Requested-By:ambari" -X PUT -d '{"RequestInfo":{"context":"Install HIVE via REST API"}, "ServiceInfo": {"state" : "INSTALLED"}}' "${BASECLU}/services/HIVE"