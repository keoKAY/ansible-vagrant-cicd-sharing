#!/bin/bash
up: 
    cd vagrant_vms/vm-one && vagrant up 
    cd vagrant_vms/vm-two && vagrant up
     
down: 
    cd vagrant_vms/vm-one && vagrant halt 
    cd vagrant_vms/vm-two && vagrant  halt
destroy: 
    cd vagrant_vms/vm-one && vagrant destroy -f 
    cd vagrant_vms/vm-two && vagrant destroy -f  
reload-one: 
    cd vagrant_vms/vm-one && vagrant reload 
reload-two: 
    cd vagrant_vms/vm-two && vagrant reload 