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

## Folder lab-3-create-service-data-model
This folder contains creating an infrastructure and service data models exercise solution.

###### Folder structure
- **data-models**
Contains several files:
  - hosts - auto-generated hosts file using nodes data from infrastructure.yml;
  - infrastructure.yml - contains base infrastructure definition data model;
  - nodes.yml - auto-generated per-node data model using infrastructure.yml;
  - svi-service.yml - service data model, which is used for creating user networks on first hop devices.

- **generated-cfgs**
Contains folders with generated configuration files:
  - infrastructure - contains base, interface and routing configuration files;
  - svi-service - contains svi/l3-subinterface configuration files.

- **j2-templates**
Contains jinja2 configuration and data models templates:
  - cisco-ios - folder for cisco ios devices;
  - cisco-nxos - folder for cisco nxos devices;
  - mikrotik-ros - folder for mikrotik devices;
  - infrastructure-to-hosts.j2 - used for generating hosts file;
  - infrastructure-to-nodes.j2 - used for generating per-node data model.

Root folder has multiple playbook files: 

* infrastructure-to-nodes.yml
This playbook generates hosts file and per-node data model using base infrastructure definition file.

* generate-infrastructure-configs.yml
This playbook generates base configuration files and stores it at generated-cfg/infrastructure directory.

* generate-svi-service-configs.yml
This playbook generates svi/l3-subinterface configuration and stores it at generated-cfg/svi-service directory.

###### Usage
1. Define your infrastructe using infrastructure.yml data model;
2. Generate hosts and per-node data model files:
```ansible-playbook infrastructure-to-nodes.yml```
3. Generate device base config using hosts files:
```ansible-playbook -i data-models/hosts generate-infrastructure-configs.yml```
4. Generate svi/l3-subinterface configuration using hosts files:
```ansible-playbook -i data-models/hosts generate-svi-service-configs.yml```