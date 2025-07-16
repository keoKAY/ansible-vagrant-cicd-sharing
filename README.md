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


## FINAL NOTES 

- Working with ansible role for better management and usuability 
- Ansible Galaxy for the import orr downloading more roles 
- Working Vault for encryption and sentitive protection 

###  ANSIBLE ROLE 
```bash
roles
└── common
    └── tasks
        ├── common-service-install.yaml
        └── main.yaml
```
