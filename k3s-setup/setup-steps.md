
Kubernete Cluster 3 Master 
```bash 
fish 
# Run Master1
# etcd 
 
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--cluster-init \
    --node-ip 192.168.56.10 \
    --advertise-address 192.168.56.10 \
    --tls-san 192.168.56.10 \
    --tls-san 192.168.56.11 \
    --tls-san 192.168.56.12 \
    --tls-san 192.168.56.8 \
    --node-taint CriticalAddonsOnly=true:NoExecute" sh -

sudo kubectl get node 
sudo kubectl get node -o wide 

sudo cat /var/lib/rancher/k3s/server/node-token

export MASTER_TOKEN=K10e726a5bb65f7925eb318b5bcd98318fdef5e53a669220217a41bb41fca0bb694::server:d8b4da7af99b585880a0a95dd1226bdf
# Master2 
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --server https://192.168.56.10:6443 --token ${MASTER_TOKEN} \
    --node-ip 192.168.56.11 \
    --advertise-address 192.168.56.11  \
    --tls-san 192.168.56.10 \
    --tls-san 192.168.56.11 \
    --tls-san 192.168.56.12 \
    --tls-san 192.168.56.8 \
    --node-taint CriticalAddonsOnly=true:NoExecute" sh -

# Master3
export MASTER_TOKEN="K10e726a5bb65f7925eb318b5bcd98318fdef5e53a669220217a41bb41fca0bb694::server:d8b4da7af99b585880a0a95dd1226bdf"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --server https://192.168.56.10:6443 --token ${MASTER_TOKEN} --node-ip 192.168.56.12  --advertise-address 192.168.56.12  --tls-san 192.168.56.10 --tls-san 192.168.56.11 --tls-san 192.168.56.12 --tls-san 192.168.56.8 --node-taint CriticalAddonsOnly=true:NoExecute" sh -

```

```bash
External Database (Postgres , mysql )

Embedded ETCD (key-value pairs )
Quorum = ( Total Node /2 + 1 ) 

Total Node = 12 
7/12

Total Size = 3 
1.5 + 1 = 2.5 = 2 


Total Size = 5 
2.5 + 1 = 3/5 


sudo systemctl stop k3s 

```


## SETUP load balancers
Client -> LB -> Cluster 

```bash 
# on BOTH lb 
sudo apt update && sudo apt upgrade -y
sudo apt install haproxy keepalived -y 


# configure MASTER LB 
sudo vim /etc/haproxy/haproxy.cfg 
sudo vim /etc/keepalived/keepalived.conf

sudo systemctl enable haproxy keepalived
sudo systemctl status haproxy # check status if it running or not 
sudo systemctl status keepalived 

sudo systemctl restart keepalived 
# check the network interface 
ip a
```



### INstall Kubectl on local machine 
```bash
# get the logs properly 
sudo journalctl -u k3s -n 50 --no-pager
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
mv ./kubectl /usr/local/bin/kubectl



kubectl get node 


# on Master1
sudo mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/config

# on local machine 
mkdir ~/.kube
scp vagrant@192.168.56.10:~/config.yaml config
mv config ~/.kube/config
```
## Reseting the clusters after setting up the LB
```bash

# Uninstall k3s completely
sudo /usr/local/bin/k3s-uninstall.sh
# Clean up all remaining data
sudo rm -rf /var/lib/rancher/k3s
sudo rm -rf /etc/rancher/k3s


# on master1
sudo k3s server --cluster-reset 
sudo rm -rf /var/lib/rancher/k3s/server/db/etcd

```