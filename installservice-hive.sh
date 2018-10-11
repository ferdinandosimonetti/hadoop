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
export BASEURL="http://${AMBARISRVHOST}:8080/api/v1/clusters/${CLUSTERNAME}"
# add services to cluster
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"ServiceInfo":{"service_name":"HIVE"}}' "${BASEURL}/services"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"ServiceInfo":{"service_name":"TEZ"}}' "${BASEURL}/services"
# confirm services
${CURLCMD} -H "X-Requested-By:ambari" -X GET "${BASEURL}/services/HIVE"
${CURLCMD} -H "X-Requested-By:ambari" -X GET "${BASEURL}/services/TEZ"
# add service components to cluster
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE SERVER"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASEURL}/services/HIVE/components/HIVE_SERVER"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE INTERACTIVE"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASEURL}/services/HIVE/components/HIVE_SERVER_INTERACTIVE"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE METASTORE"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASEURL}/services/HIVE/components/HIVE_METASTORE"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install HIVE CLIENT"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASEURL}/services/HIVE/components/HIVE_CLIENT"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"RequestInfo":{"context":"Install TEZ CLIENT"}, "Body":{"HostRoles":{"state":"INSTALLED"}}}' "${BASEURL}/services/TEZ/components/TEZ_CLIENT"
# load INITIAL service configurations
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@tez-env-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@tez-site-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@tez-interactive-site-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-env-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-site-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hivemetastore-site-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-interactive-env-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hive-interactive-site-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hiveserver2-site-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@hiveserver2-interactive-site-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@llap-daemon-log4j-INITIAL.json' "${BASEURL}/configurations"
${CURLCMD} -H "X-Requested-By:admin" -X POST -d '@llap-cli-log4j2-INITIAL.json' "${BASEURL}/configurations"
# apply service configurations
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "tez-env", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "tez-site", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "tez-interactive-site", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-env", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-site", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hivemetastore-site", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-interactive-env", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hive-interactive-site", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hiveserver2-site", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "hiveserver2-interactive-site", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "llap-daemon-log4j", "tag" : "INITIAL" }}}' ${BASEURL}
${CURLCMD} -H "X-Requested-By:admin" -X PUT -d '{ "Clusters" : {"desired_configs": {"type": "llap-cli-log4j2", "tag" : "INITIAL" }}}' ${BASEURL}
# create "server" host components
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_SERVER"}}] }' "${BASEURL}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_SERVER_INTERACTIVE"}}] }' "${BASEURL}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_METASTORE"}}] }' "${BASEURL}/hosts?Hosts/host_name=${HIVEMSHOST}"
# create "client" host components 
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_CLIENT"}}] }' "${BASEURL}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"HIVE_CLIENT"}}] }' "${BASEURL}/hosts?Hosts/host_name=${HIVEMSHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"TEZ_CLIENT"}}] }' "${BASEURL}/hosts?Hosts/host_name=${HIVESRVHOST}"
${CURLCMD} -H "X-Requested-By:ambari" -X POST -d '{"host_components" : [{"HostRoles":{"component_name":"TEZ_CLIENT"}}] }' "${BASEURL}/hosts?Hosts/host_name=${HIVEMSHOST}"
# install the services
${CURLCMD} -H "X-Requested-By:ambari" -X PUT -d '{"RequestInfo":{"context":"Install TEZ via REST API"}, "ServiceInfo": {"state" : "INSTALLED"}}' "${BASEURL}/services/TEZ"
${CURLCMD} -H "X-Requested-By:ambari" -X PUT -d '{"RequestInfo":{"context":"Install HIVE via REST API"}, "ServiceInfo": {"state" : "INSTALLED"}}' "${BASEURL}/services/HIVE"