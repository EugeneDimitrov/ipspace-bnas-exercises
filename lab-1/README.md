# Build Your Own Network Automation Lab Exercise
This lab were created using GNS3 application.

## Images used
Cisco L3 vios-adventerprisek9-m.vmdk.SPA.156-2.T
Cisco L2 vios_l2-adventerprisek9-m.vmdk.SSA.152-4.0.55.E
Mikrotik chr-6.41.4

## Topology
You can find network topology scheme in topology.png file under img folder:
<img src="img/topolgy.png">
All devices connected using dedicated management 172.16.30.0/24 network.
Ansible VM located on the same ESXi host as GNS3 VM, and it's also connected to this network using 172.16.30.1 address.   
