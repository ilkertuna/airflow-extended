FROM apache/airflow:2.10.2
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         openjdk-17-jre-headless \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER airflow
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

ARG AIRFLOW_EXTRAS="apache.atlas,apache.spark,apache.hive,amazon,jdbc,sqlite,celery,postgres,redis,mysql,ssh"
RUN pip install apache-airflow[${AIRFLOW_EXTRAS}]
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" apache-airflow-providers-apache-spark
RUN pip install --no-cache-dir pyspark
RUN pip install --no-cache-dir apache-airflow-providers-amazon
RUN pip install --no-cache-dir airflow-clickhouse-plugin[pandas]
