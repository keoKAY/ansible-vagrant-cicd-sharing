## NOTE 


- IaC = Infrastructure as Code
- CaC = Configuration as Code 


ex. IaC (Ansible, Terraform )
Kubernete Cluster 
3 masters 
2 workers 



## Requirement 

- Install ansible
- Install vagrant 
- Install Virtualbox ( optional: if you already have VMware )


```bash 
mkdir my-first-vm
cd my-first-vm 
vagrant init ubuntu/jammy64
vagrant up 
vagrant status 
vagrant halt 
vagrant ssh 
vagrant ssh-config

```

## Setting up machine one 
```bash 
mkdir machine-one 
cd machine-one 
vagrant init ubuntu/jammy64
# changing config before you up it 
vagrant up 
vagrant status 

vagrant ssh 

# inside the vm 
sudo systemctl status nginx 
curl localhost # welcome to nginx 


# to reapply the change and clean the  old one 
vagrant destroy -f 
vagrant up 

ansible -i inventory.ini all -m ping
ansible -i inventory.ini nfs-network -m ping 
```




## Deploy service with the data persistence 
```bash
docker pull 69966/springgradleimg:1.1.1
```


# Keepalived 
- control + F `keepalived.conf.j2`
***
### Our agenda 
- soruce code after you clone : `git checkout IaCDemo `

[o] completing loadbalancer 
- After setup masters 
- we will setup workers 
- setup clients 

- kubernetes lesson 
- explore different obj in kubernetes 

```bash
sudo systemctl status k3s 
sudo systemctl restart k3s # if the service activating 
sudo kubectl get node  
```



local -> run kubectl get node -> lb-master -> k3s-cluster