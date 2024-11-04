---
- name: install haproy
  hosts: ha_prox
  become: yes
  roles:
    - haproxy 
    - keepalived 
- name: install k8s
  hosts: hosts
  become: yes
  roles:
     - programs
     - ntp
     - swap_off
     - mod_forwd
     - k8s_repo
     - kub_kubeadm_kubctl
     - cri-o
- name: control plane
  hosts: master
  become: yes
  roles:
     - init_control
     - calico
     - helm
     - helm_install
- name: worker node
  hosts: worker
  become: yes
  roles:
     - init_worker
     - control 
...

