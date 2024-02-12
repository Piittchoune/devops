# Inventory
https://blog.stephane-robert.info/docs/infra-as-code/gestion-de-configuration/ansible/inventaires/
## Static inventory

- Inventory = inventory of nodes and their variables

- Essential component because its define the infrastructures (servers, workstation, router, switch, etc)

- Separated in two instances:
  - **host**
  - **groups**

- Multiple format: 
  - ini (the prefered ones)
  - yaml
  - json (better for handle inventory)

- Finaly the inventory is:
  - inventory files
  - group_vars directory
  - host_vars directory

root groups is **all**

### example:

- parent 1 groups
- children groups : child1 and child2
- "sub" child of child2 : child3
- child1 = srv1 et srv2
- child2 = srv3
- child1 = srv4
- child3 = srv5

Ini format: 

```ini
[parent1]
srv4
[child1]
srv1
srv2
[child2]
srv3
[child3]
srv5
[parent1:children]
child1
child2
[child2:children]
child3
```

Yaml format:

```yaml
all:
  children:
    parent1:
      hosts:
        srv4:
      children:
        child1:
          hosts:
            srv1:
            srv2:
        child2:
          hosts:
            srv3:
        children:
          child3:
            hosts:
              srv5:
```

* passer un groupe à un autre groupe


```yaml
all: 
  children:
    parent1:
      parent2:
      hosts:
        srv4:
      children:
        enfant1:
          hosts:
            srv1:
            srv2:
        enfant2:
          hosts:
            srv3:
          children:
            enfant3:
              hosts:
                srv5:
    parent2:
      hosts:
        srv6:
        srv7:
        srv8:
        srv9:
```


* pattern

```yaml
all: 
  children:
    parent1:
      parent2:
      hosts:
        srv4:
      children:
        enfant1:
          hosts:
            srv[1:2]:
        enfant2:
          hosts:
            srv3:
          children
            enfant3:
              hosts:
                srv5:
    parent2:
      hosts:
        srv[6:]:
```

* un peu plus vers la pratique
		* couche commune > common
		* serveurs web nginx > webserver 
		* bases de données > dbserver
		* applications dockerisées ou non > app / appdock
    * monitoring qui semble lié à toutes les machines users > monitoring

```yaml
all:
  children:
    common:
      children:
        webserver:
          hosts:
            srv[1:4]:
        dbserver:
          hosts:
            srv[5:6]:
        app:
          hosts:
            srv[7:10]:
        appdock:
          hosts:
            srv[11:15]:
    monitoring:
      children:
        common:
```

Format json : https://linuxhint.com/ansible_inventory_json_format/
