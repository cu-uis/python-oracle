FROM python:3.6.5-slim
RUN apt-get update && apt-get -y install cron  && apt-get -y install rsyslog && apt-get -y install vim && apt-get -y install wget && apt-get -y install unzip && apt-get -y install libaio1 && apt-get -y install procps
RUN service cron start && service rsyslog start
RUN pip3 install pandas && pip3 install pika && pip3 install cx_oracle

RUN mkdir -p /scripts
COPY ciwdev-connectionTest.py /scripts/ciwdev-connectionTest.py

RUN mkdir -p /opt/oracle
WORKDIR /opt/oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basic-linux.x64-21.1.0.0.0.zip && unzip instantclient-basic-linux.x64-21.1.0.0.0.zip
#WORKDIR /opt/oracle/instantclient_21_1
RUN cp -a /opt/oracle/instantclient_21_1/. /set && cp -a /set/. /opt/oracle/instantclient_21_1/lib && sh -c "echo /opt/oracle/instantclient_21_1 > /etc/ld.so.conf.d/oracle-instantclient.conf" && ldconfig
ENV ORACLE_HOME=/opt/oracle/instantclient_12_1 DYLD_LIBRARY_PATH=$ORACLE_HOME LD_LIBRARY_PATH=$ORACLE_HOME PATH=$ORACLE_HOME:$PATH

WORKDIR /
CMD tail -f /dev/null
