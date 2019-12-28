# ipspace-bnas-exercises
Hands-On Exercise Solutions for Building Network Automation Solutions Course

## Installation
You may need to use special Ansible inv setting using setup_ansible_env.sh script.
Also some playbooks require addition plugin such as NAPALM. You must install it at "plugins" folder.

## Folder lab-1-create-virtual-lab
This folder contains virtual lab description

## Folder lab-2-summary-report
This folder contains report exercise solution, which consists of multiple playbook files:

* 01-get-interfaces-status.yml
This playbook gathers information about device name, vendor name, serial number, interface names and its state using NAPALM plugin.

The final results are represented in a text file named ./output/01-interfaces-status-report.log. 
Content of this file is provided below:
```
========================     dc-r2     ========================
hostname: dc-r2
vendor name: Cisco
serial number: 9KQ3FY12FVT

---------------------------------------------------------------
| Interface name      | Admin state    | Connection state     |
---------------------------------------------------------------
| GigabitEthernet1    | Down           | Down                 |
| GigabitEthernet2    | Down           | Down                 |
| GigabitEthernet3    | Up             | Up                   |
| GigabitEthernet4    | Down           | Down                 |
| GigabitEthernet5    | Down           | Down                 |
| GigabitEthernet6    | Down           | Down                 |
---------------------------------------------------------------
```

* 02-get-hsrp-status.yml
This playbook gathers information about device name and HSRP state information.
Supported only Cisco NXOS devices so far.

The final results are represented in a text file named ./output/02-hsrp-status-report.log. 
Content of this file is provided below:
```
=============================     dc-sw1     =============================

--------------------------------------------------------------------------
| Interface name  | HSRP Group id  | Virtual IP address  | Group state   |
--------------------------------------------------------------------------
| Vlan10          | 10             | 10.100.1.254        | Active        |
| Vlan11          | 11             | 10.100.2.254        | Standby       |
--------------------------------------------------------------------------

=============================     dc-sw2     =============================

--------------------------------------------------------------------------
| Interface name  | HSRP Group id  | Virtual IP address  | Group state   |
--------------------------------------------------------------------------
| Vlan10          | 10             | 10.100.1.254        | Standby       |
| Vlan11          | 11             | 10.100.2.254        | Active        |
--------------------------------------------------------------------------
```