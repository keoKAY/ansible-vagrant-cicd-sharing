
Kubernete Cluster 3 Master 
```bash 
fish 
# Run Master1 
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--cluster-init --node-ip 192.168.56.10 --advertise-address 192.168.56.10 --tls-san 192.168.56.10 --tls-san 192.168.56.11 --tls-san 192.168.56.12 --node-taint CriticalAddonsOnly=true:NoExecute" sh -

sudo kubectl get node 
sudo kubectl get node -o wide 

sudo cat /var/lib/rancher/k3s/server/node-token

# Master2 
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --server https://192.168.56.10:6443 --token K1003f49ef9ef06a935efa3b41268b75202e356248eee5e5bcfd4d1556c3ae5e028::server:d159e523a86e6396ab8ff6e95a9b2015  --node-ip 192.168.56.11 --advertise-address 192.168.56.11  --tls-san 192.168.56.10 --tls-san 192.168.56.11 --tls-san 192.168.56.12 --node-taint CriticalAddonsOnly=true:NoExecute" sh -

# Master3
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --server https://192.168.56.10:6443 --token K1003f49ef9ef06a935efa3b41268b75202e356248eee5e5bcfd4d1556c3ae5e028::server:d159e523a86e6396ab8ff6e95a9b2015  --node-ip 192.168.56.12 --advertise-address 192.168.56.12  --tls-san 192.168.56.10 --tls-san 192.168.56.11 --tls-san 192.168.56.12 --node-taint CriticalAddonsOnly=true:NoExecute" sh -

```