FROM debian

MAINTAINER Matthias Munz <matthias.munz@gmx.de>

RUN apt-get update && apt-get -y --no-install-recommends install ruby ruby-dev bundler build-essential libcurl4-openssl-dev gnupg wget && apt-get clean
RUN /usr/bin/apt-key adv --keyserver pool.sks-keyservers.net --recv 1078ECD7
RUN echo "deb http://apt.arvados.org/ bionic main" | tee /etc/apt/sources.list.d/arvados.list
RUN apt-get update && apt-get -y --no-install-recommends install python-arvados-python-client python-arvados-fuse && apt-get clean
RUN gem install arvados-cli
RUN RUN apt-get update && apt-get -y --no-install-recommends install wget && \
cd /usr/local/share/ca-certificates && \
wget -q -O RocheRootCA.cer http://certinfo.roche.com/rootcerts/Roche%20Root%20CA%201.cer && \
wget -q -O RocheEnterpriseCA1.cer http://certinfo.roche.com/rootcerts/RocheEnterpriseCA1.cer && \
wget -q -O RocheEnterpriseCA2.cer http://certinfo.roche.com/rootcerts/RocheEnterpriseCA2.cer && \
wget -q -O RocheRootCA1-G2.crt http://certinfo.roche.com/rootcerts/Roche%20Root%20CA%201%20-%20G2.crt && \
wget -q -O RocheEnterpriseCA1-G2.crt http://certinfo.roche.com/rootcerts/Roche%20Enterprise%20CA%201%20-%20G2.crt && \
wget -q -O RocheG3RootCA.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Root%20CA.crt && \
wget -q -O RocheG3IssuingCA1.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%201.crt && \
wget -q -O RocheG3IssuingCA2.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%202.crt && \
wget -q -O RocheG3IssuingCA3.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%203.crt && \
wget -q -O RocheG3IssuingCA4.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%204.crt && \
openssl x509 -in RocheRootCA.cer -inform der -outform pem > RocheRootCA.crt && \
openssl x509 -in RocheEnterpriseCA1.cer -inform der -outform pem > RocheEnterpriseCA1.crt && \
openssl x509 -in RocheEnterpriseCA2.cer -inform der -outform pem > RocheEnterpriseCA2.crt && \
update-ca-certificates

