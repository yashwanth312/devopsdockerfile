FROM centos

#Installing the required softwares insdie the container -- 1. openssh-server : for connectivity of jenkins cloud slave with the container (using SSH keygen).              
# -- 2. java : for cloud based applications to run inside the container.
RUN yum install openssh-server -y 
RUN yum install java -y
RUN ssh-keygen -A

#Starting the sshd services.
CMD ["/usr/sbin/sshd:, "-D"] && /bin/bash 

#Downloading the kubectl command.

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

#Making the kubectl command accessible irrespective of the path.
RUN chmod +x ./kubectl
RUN mv kubectl /usr/bin/

#COpying the certoficates and keys required for kubectl access inside the container.
COPY ca.crt /root/
COPY client.crt  /root/
COPY client.key  /root/
CMD mkdir /root/.kube
COPY config /root/.kube/



 
