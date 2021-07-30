#!/usr/bin/env bash
################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

STAGE_COMPILE="compile"
STAGE_CORE="core"
STAGE_PYTHON="python"
STAGE_LIBRARIES="libraries"
STAGE_BLINK_PLANNER="blink_planner"
STAGE_CONNECTORS="connectors"
STAGE_KAFKA_GELLY="kafka/gelly"
STAGE_TESTS="tests"
STAGE_MISC="misc"
STAGE_CLEANUP="cleanup"
STAGE_FINEGRAINED_RESOURCE_MANAGEMENT="finegrained_resource_management"

MODULES_CORE="\
org.apache.flink-annotations,\
org.apache.flink-test-utils-parent/org.apache.flink-test-utils,\
org.apache.flink-state-backends/org.apache.flink-statebackend-rocksdb,\
org.apache.flink-clients,\
org.apache.flink-core,\
org.apache.flink-java,\
org.apache.flink-optimizer,\
org.apache.flink-runtime,\
org.apache.flink-runtime-web,\
org.apache.flink-scala,\
org.apache.flink-streaming-java,\
org.apache.flink-streaming-scala,\
org.apache.flink-metrics,\
org.apache.flink-metrics/org.apache.flink-metrics-core,\
org.apache.flink-external-resources,\
org.apache.flink-external-resources/org.apache.flink-external-resource-gpu"

MODULES_LIBRARIES="\
org.apache.flink-libraries/org.apache.flink-cep,\
org.apache.flink-libraries/org.apache.flink-cep-scala,\
org.apache.flink-libraries/org.apache.flink-state-processing-api,\
org.apache.flink-table/org.apache.flink-table-common,\
org.apache.flink-table/org.apache.flink-table-api-java,\
org.apache.flink-table/org.apache.flink-table-api-scala,\
org.apache.flink-table/org.apache.flink-table-api-java-bridge,\
org.apache.flink-table/org.apache.flink-table-api-scala-bridge,\
org.apache.flink-table/org.apache.flink-table-planner,\
org.apache.flink-table/org.apache.flink-sql-client"

MODULES_BLINK_PLANNER="\
org.apache.flink-table/org.apache.flink-table-planner-blink,\
org.apache.flink-table/org.apache.flink-table-runtime-blink"

MODULES_CONNECTORS="\
org.apache.flink-contrib/org.apache.flink-connector-wikiedits,\
org.apache.flink-filesystems,\
org.apache.flink-filesystems/org.apache.flink-fs-hadoop-shaded,\
org.apache.flink-filesystems/org.apache.flink-hadoop-fs,\
org.apache.flink-filesystems/org.apache.flink-mapr-fs,\
org.apache.flink-filesystems/org.apache.flink-oss-fs-hadoop,\
org.apache.flink-filesystems/org.apache.flink-s3-fs-base,\
org.apache.flink-filesystems/org.apache.flink-s3-fs-hadoop,\
org.apache.flink-filesystems/org.apache.flink-s3-fs-presto,\
org.apache.flink-fs-tests,\
org.apache.flink-formats,\
org.apache.flink-formats/org.apache.flink-avro-confluent-registry,\
org.apache.flink-formats/org.apache.flink-avro,\
org.apache.flink-formats/org.apache.flink-parquet,\
org.apache.flink-formats/org.apache.flink-sequence-file,\
org.apache.flink-formats/org.apache.flink-json,\
org.apache.flink-formats/org.apache.flink-csv,\
org.apache.flink-formats/org.apache.flink-orc,\
org.apache.flink-formats/org.apache.flink-orc-nohive,\
org.apache.flink-connectors/org.apache.flink-connector-hbase-base,\
org.apache.flink-connectors/org.apache.flink-connector-hbase-1.4,\
org.apache.flink-connectors/org.apache.flink-connector-hbase-2.2,\
org.apache.flink-connectors/org.apache.flink-hcatalog,\
org.apache.flink-connectors/org.apache.flink-hadoop-compatibility,\
org.apache.flink-connectors,\
org.apache.flink-connectors/org.apache.flink-connector-jdbc,\
org.apache.flink-connectors/org.apache.flink-connector-cassandra,\
org.apache.flink-connectors/org.apache.flink-connector-elasticsearch5,\
org.apache.flink-connectors/org.apache.flink-connector-elasticsearch6,\
org.apache.flink-connectors/org.apache.flink-connector-elasticsearch7,\
org.apache.flink-connectors/org.apache.flink-sql-connector-elasticsearch6,\
org.apache.flink-connectors/org.apache.flink-sql-connector-elasticsearch7,\
org.apache.flink-connectors/org.apache.flink-connector-elasticsearch-base,\
org.apache.flink-connectors/org.apache.flink-connector-nifi,\
org.apache.flink-connectors/org.apache.flink-connector-rabbitmq,\
org.apache.flink-connectors/org.apache.flink-connector-twitter,\
org.apache.flink-connectors/org.apache.flink-connector-kinesis,\
org.apache.flink-metrics/org.apache.flink-metrics-dropwizard,\
org.apache.flink-metrics/org.apache.flink-metrics-graphite,\
org.apache.flink-metrics/org.apache.flink-metrics-jmx,\
org.apache.flink-metrics/org.apache.flink-metrics-influxdb,\
org.apache.flink-metrics/org.apache.flink-metrics-prometheus,\
org.apache.flink-metrics/org.apache.flink-metrics-statsd,\
org.apache.flink-metrics/org.apache.flink-metrics-datadog,\
org.apache.flink-metrics/org.apache.flink-metrics-slf4j,\
org.apache.flink-queryable-state/org.apache.flink-queryable-state-runtime,\
org.apache.flink-queryable-state/org.apache.flink-queryable-state-client-java"

MODULES_KAFKA_GELLY="\
org.apache.flink-libraries/org.apache.flink-gelly,\
org.apache.flink-libraries/org.apache.flink-gelly-scala,\
org.apache.flink-libraries/org.apache.flink-gelly-examples,\
org.apache.flink-connectors/org.apache.flink-connector-kafka,\
org.apache.flink-connectors/org.apache.flink-sql-connector-kafka,"

MODULES_TESTS="\
org.apache.flink-tests"

MODULES_LEGACY_SLOT_MANAGEMENT=${MODULES_CORE},${MODULES_TESTS}

MODULES_FINEGRAINED_RESOURCE_MANAGEMENT=${MODULES_CORE},${MODULES_TESTS}

# we can only build the Scala Shell when building for Scala 2.11
if [[ $PROFILE == *"scala-2.11"* ]]; then
    MODULES_CORE="$MODULES_CORE,org.apache.flink-scala-shell"
fi

function get_compile_modules_for_stage() {
    local stage=$1

    case ${stage} in
        (${STAGE_CORE})
            echo "-pl $MODULES_CORE -am"
        ;;
        (${STAGE_LIBRARIES})
            echo "-pl $MODULES_LIBRARIES -am"
        ;;
        (${STAGE_BLINK_PLANNER})
            echo "-pl $MODULES_BLINK_PLANNER -am"
        ;;
        (${STAGE_CONNECTORS})
            echo "-pl $MODULES_CONNECTORS -am"
        ;;
        (${STAGE_KAFKA_GELLY})
            echo "-pl $MODULES_KAFKA_GELLY -am"
        ;;
        (${STAGE_TESTS})
            echo "-pl $MODULES_TESTS -am"
        ;;
        (${STAGE_MISC})
            # compile everything; using the -am switch does not work with negated module lists!
            # the negation takes precedence, thus not all required modules would be built
            echo ""
        ;;
        (${STAGE_PYTHON})
            # compile everything for PyFlink.
            echo ""
        ;;
        (${STAGE_FINEGRAINED_RESOURCE_MANAGEMENT})
            echo "-pl $MODULES_FINEGRAINED_RESOURCE_MANAGEMENT -am"
        ;;
    esac
}

function get_test_modules_for_stage() {
    local stage=$1

    local modules_core=$MODULES_CORE
    local modules_libraries=$MODULES_LIBRARIES
    local modules_blink_planner=$MODULES_BLINK_PLANNER
    local modules_connectors=$MODULES_CONNECTORS
    local modules_tests=$MODULES_TESTS
    local negated_core=\!${MODULES_CORE//,/,\!}
    local negated_libraries=\!${MODULES_LIBRARIES//,/,\!}
    local negated_blink_planner=\!${MODULES_BLINK_PLANNER//,/,\!}
    local negated_kafka_gelly=\!${MODULES_KAFKA_GELLY//,/,\!}
    local negated_connectors=\!${MODULES_CONNECTORS//,/,\!}
    local negated_tests=\!${MODULES_TESTS//,/,\!}
    local modules_misc="$negated_core,$negated_libraries,$negated_blink_planner,$negated_connectors,$negated_kafka_gelly,$negated_tests"
    local modules_finegrained_resource_management=$MODULES_FINEGRAINED_RESOURCE_MANAGEMENT

    case ${stage} in
        (${STAGE_CORE})
            echo "-pl $modules_core"
        ;;
        (${STAGE_LIBRARIES})
            echo "-pl $modules_libraries"
        ;;
        (${STAGE_BLINK_PLANNER})
            echo "-pl $modules_blink_planner"
        ;;
        (${STAGE_CONNECTORS})
            echo "-pl $modules_connectors"
        ;;
        (${STAGE_KAFKA_GELLY})
            echo "-pl $MODULES_KAFKA_GELLY"
        ;;
        (${STAGE_TESTS})
            echo "-pl $modules_tests"
        ;;
        (${STAGE_MISC})
            echo "-pl $modules_misc"
        ;;
        (${STAGE_FINEGRAINED_RESOURCE_MANAGEMENT})
            echo "-pl $modules_finegrained_resource_management"
        ;;
    esac
}
