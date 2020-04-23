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
**data-models**

Contains several files:
  - hosts - auto-generated hosts file using nodes data from infrastructure.yml;
  - infrastructure.yml - contains base infrastructure definition data model;
  - svi-service.yml - service data model, which is used for creating user networks on first hop devices.
  - nodes-infrastructure.yml - auto-generated per-node data model using infrastructure.yml;
  - nodes-svi-service.yml - auto-generated per-node data model using svi-service.yml;

**generated-cfgs**

Contains folders with generated configuration files:
  - infrastructure - contains base, interface and routing configuration files;
  - svi-service - contains svi/l3-subinterface configuration files.

**j2-templates**

Contains jinja2 configuration and data models templates:
  - ios - folder for cisco ios devices;
  - nxos - folder for cisco nxos devices;
  - routeros - folder for mikrotik devices;
  - infrastructure-to-hosts.j2 - used for generating hosts file;
  - infrastructure-to-nodes.j2 - used for generating infrastructure per-node data model;
  - svi-service-to-nodes.j2 - used for generating svi-service per-node data model;
  - napalm-validate-01-base.j2 - used for generating napalm_validate files against base configuration;
  - napalm-validate-10-interfaces.j2 - used for generating napalm_validate files against interfaces configuration;
  - napalm-validate-99-connectivity.j2 - used for generating napalm_validate files for ICMP connectivity checks;
  - napalm-validate-svi-service.j2 - used for generating napalm_validate files against SVI interfaces configuration.

**napalm-validation**

Contains napalm validation data models.

Root folder has multiple playbook files: 
- generate-napalm-validation-files.yml
This playbook generates napalm_validate files data model.

- infrastructure-to-nodes.yml
This playbook generates hosts file and per-node data model using base infrastructure definition file.

- svi-service-to-nodes.yml
This playbook generates svi/l3-subinterface per-node data model using svi-service definition file.

- generate-infrastructure-configs.yml
This playbook generates base configuration files and stores it at generated-cfg/infrastructure directory.

- generate-svi-service-configs.yml
This playbook generates svi/l3-subinterface configuration and stores it at generated-cfg/svi-service directory.

###### Usage
1. Define your infrastructure using infrastructure.yml data model;
2. Define your SVI/l3-subinterface service using svi-service.yml data model;
3. Generate hosts and per-node data model files:

```ansible-playbook infrastructure-to-nodes.yml```

4. Generate per-node SVI/l3-subinterface service data model files:

```ansible-playbook svi-service-to-nodes.yml```

5. Generate device infrastructure config using hosts files:

```ansible-playbook -i data-models/hosts generate-infrastructure-configs.yml```

6. Generate svi/l3-subinterface configuration using hosts files:

```ansible-playbook -i data-models/hosts generate-svi-service-configs.yml```

7. Generate NAPALM validation files:

```ansible-playbook -i data-models/hosts generate-napalm-validation-files.yml```


## Folder lab-4-change-network-configurations

This folder contains changing network configurations exercise solution.

###### Folder structure

**deploy-infrastructure**

Contains multiple playbook files: 
- 01-deploy-base-config.yml
This playbook deploys base configuration to device.
- 10-deploy-interfaces-config.yml
This playbook deploys interface configuration to device.
- 20-deploy-routing-config.yml
This playbook deploys routing configuration to device.

###### Usage

Then run these "deploy" playbooks with no commands, e.g.:

```ansible-playbook -i ../../lab-3-create-service-data-model/data-models/hosts 01-deploy-base-config.yml```

It calculates diffs between desired configs generated by data models and actual device state, and stores it in cfg-diffs directory. To apply config, you need to run same playbook with "commit_changes=true" var, e.g.:

```ansible-playbook -i ../../lab-3-create-service-data-model/data-models/hosts 01-deploy-base-config.yml -e "commit_changes=true"```

NOTE: Mikrotik device doesn't support config diff function.

- 01-validate-base-config.yml
This playbook validates deployed base configuration.

- 10-validate-interfaces-config.yml
This playbook validates deployed interfaces configuration.

- 20-validate-routing-config.yml
This playbook validates deployed routing configuration.

- 99-validate-connectivity.yml
This playbook validates deployed configuration using ping utility.

###### Usage

```ansible-playbook -i ../../lab-3-create-service-data-model/data-models/hosts 99-validate-connectivity.yml```

You should get all OK's:

```
PLAY RECAP *********************************************************************************************************************************************************
dc-r1                      : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
dc-r2                      : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
dc-sw1                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
dc-sw2                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
hub-r1                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
hub-r2                     : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
hub-sw1                    : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
spoke1-r1                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
spoke2-r1                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
spoke3-r1                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

**deploy-svi-service**

Contains multiple playbook files: 

- deploy-svi-service-config.yml

###### Usage

This playbook deploys svi service configuration to device.
Then run these "deploy" playbooks with no commands, e.g.:

```ansible-playbook -i ../../lab-3-create-service-data-model/data-models/hosts deploy-svi-service-config.yml```

It calculates diffs between desired configs generated by data models and actual device state, and stores it in cfg-diffs directory. To apply config, you need to run same playbook with "commit_changes=true" var, e.g.:

```ansible-playbook -i ../../lab-3-create-service-data-model/data-models/hosts deploy-svi-service-config.yml -e "commit_changes=true"```

NOTE: Mikrotik device doesn't support config diff function.

- validate-svi-service-config.yml

This playbook validates deployed svi service configuration.

###### Usage

```ansible-playbook -i ../../lab-3-create-service-data-model/data-models/hosts validate-svi-service-config.yml```

- clean-svi-service-config.yml
This playbook remove interface configuration from device if it has "remove" state in SVI service data model

**j2-templates**

Contains jinja2 interface configuration diff calculation template.

**pre-config-setup**

Contains playbooks for lab preconfiguration.

**textfsm-templates**

Contains textfsm templates.