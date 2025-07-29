#!/bin/bash
iac: 
    echo "=> Creating all vms from vm_machine.yaml file " 
    ansible-playbook playbooks/iaC.yaml
#just run iac
reset-ssh: 
    ssh-keygen -R 192.168.56.10
    ssh-keygen -R 192.168.56.11
    ssh-keygen -R 192.168.56.12
    ssh-keygen -R 192.168.56.13
    ssh-keygen -R 192.168.56.9
    ssh-keygen -R 192.168.56.15
up-all: 
    cd vagrant_vms/master1 && vagrant up 
    cd vagrant_vms/master2 && vagrant up 
    cd vagrant_vms/master3 && vagrant up 
    cd vagrant_vms/lb-master && vagrant up 
    cd vagrant_vms/lb-backup && vagrant up 
    cd vagrant_vms/agent1 && vagrant up 
# just up-all     
up name: 
    #!/bin/bash
    echo "Bring {{name }} up! " 
    cd vagrant_vms/{{name}} && vagrant up 
down-all: 
    cd vagrant_vms/master1 && vagrant halt 
    cd vagrant_vms/master2 && vagrant halt 
    cd vagrant_vms/master3 && vagrant halt 
    cd vagrant_vms/lb-master && vagrant halt 
    cd vagrant_vms/lb-backup && vagrant halt
destroy-all: 
    cd vagrant_vms/master1 && vagrant destroy -f  
    cd vagrant_vms/master2 && vagrant destroy -f  
    cd vagrant_vms/master3 && vagrant destroy -f  
    cd vagrant_vms/lb-master && vagrant destroy -f  
    cd vagrant_vms/lb-backup && vagrant destroy -f 
    cd vagrant_vms/agent1 && vagrant destroy -f 
reload name: 
    #!/bin/bash
    cd vagrant_vms/{{name}} && vagrant reload 

run name: 
    #!/bin/bash
    echo "=> Running playbook = {{name}}.yaml 📖" 
    ansible-playbook -i inventory2.yaml playbooks/{{name}}.yaml