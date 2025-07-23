
Kubernete Cluster 3 Master 
```bash 
fish 
# Run Master1
# etcd 
 
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--cluster-init --node-ip 192.168.56.10 --advertise-address 192.168.56.10 --tls-san 192.168.56.10 --tls-san 192.168.56.11 --tls-san 192.168.56.12 --tls-san 192.168.56.8 --node-taint CriticalAddonsOnly=true:NoExecute" sh -

sudo kubectl get node 
sudo kubectl get node -o wide 

sudo cat /var/lib/rancher/k3s/server/node-token

export MASTER_TOKEN="K10ff9a3e446f0bef1d40d31114727cb47f214e35189f443675e46bec0f28cc02ae::server:03215a9cf7c297180768c9e0b89f2f22"
# Master2 
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --server https://192.168.56.10:6443 --token K10ff9a3e446f0bef1d40d31114727cb47f214e35189f443675e46bec0f28cc02ae::server:03215a9cf7c297180768c9e0b89f2f22 --node-ip 192.168.56.11 --advertise-address 192.168.56.11  --tls-san 192.168.56.10 --tls-san 192.168.56.11 --tls-san 192.168.56.12 --tls-san 192.168.56.8 --node-taint CriticalAddonsOnly=true:NoExecute" sh -

# Master3
export MASTER_TOKEN="K10ff9a3e446f0bef1d40d31114727cb47f214e35189f443675e46bec0f28cc02ae::server:03215a9cf7c297180768c9e0b89f2f22"
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
# to only see the errors 
sudo journalctl -u k3s -f --no-pager | grep -i error

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


## Another way to stop it 
```bash
sudo /usr/local/bin/k3s-uninstall.sh
sudo rm -rf .kube # inside your home directory 
# On the joining node, stop k3s completely
sudo systemctl stop k3s
sudo systemctl disable k3s

# Clean up any remaining k3s processes
sudo pkill -f k3s

# Remove k3s data directory
sudo rm -rf /var/lib/rancher/k3s
sudo rm -rf /etc/rancher/k3s

# Now try joining with explicit memory settings
sudo k3s agent \
  --server https://<MASTER_IP>:6443 \
  --token <YOUR_NODE_TOKEN> \
  --node-ip <THIS_NODE_IP> \
  --kubelet-arg="max-pods=50" \
  --kubelet-arg="pods-per-core=5"

```