# Inventory

**Inventory is the Ansible fundamentals concepts. Its essentials to list and manage servers, computer and other IT stuff that are managed by ansible automation scripts.**

Ansible inventories can be **static**, where host details are defined and stored in YAML or INI files, or **dynamic**, automatically adapting to changing environments by querying external data sources. This duality enables efficient management both in stable environments and in dynamic cloud contexts, where instances can be frequently created and destroyed.

## Static inventories

Static inventories are those most often on which many Ansible automations are based. They allow to define explicitly and immutable hosts and groups with which Ansible will interact. These inventories can be written in two main formats: INI and YAML, each with its advantages and specificities.

A basic Ansible inventory is a file in INI or YAML format. In its simplest form, the inventory file can list hosts under a defined group:

```ini
# INI Format
[web]
192.168.1.101
192.168.1.102
```

This structure already allows specific Ansible tasks to be run on the servers_web group. However, Ansible also allows you to define child groups and assign host or group variables to further customize configurations.

Ansible also allows you to define variables at the host or group level, which provides incredible flexibility to customize the behaviors of Ansible modules without having to write multiple tasks for each host. Variables can be defined directly in the inventory file or in separate files to organize the configuration.

```ini
# INI Format
[web]
web1 ansible_host=192.168.1.101 ansible_user=admin
web2 ansible_host=192.168.1.102 ansible_user=admin

[web:vars]
nginx_version=1.18.0
```

### INI Format

The INI format is the simplest and most direct to create an inventory. It is particularly appreciated for its readability and ease of writing. Here is an example of a static inventory in INI format:

```ini
[web]
web1.example.com ansible_user=admin
web2.example.com ansible_user=admin

[database]
db1.example.com ansible_user=dbadmin
db2.example.com ansible_user=dbadmin

[web:vars]
nginx_version=1.18.0
```

In this example, *web* and *database* are host groups. *web:vars* defines variables that are applied to all hosts in the *web* group.

### YAML Format

The YAML format, on the other hand, offers a richer structure and is often preferred for more complex inventories. YAML allows a more hierarchical representation and is particularly useful for defining nested structures and variables in a more visual way. Here is how the same inventory would be represented in YAML:

```yaml
all:
  children:
    web:
      hosts:
        web1.example.com:
          ansible_user: admin
        web2.example.com:
          ansible_user: admin
      vars:
        nginx_version: "1.18.0"
    database:
      hosts:
        db1.example.com:
          ansible_user: dbadmin
        db2.example.com:
          ansible_user: dbadmin
```

This format allows not only to define hosts and groups, but also to organize subgroups and assign variables to specific levels of the hierarchy.

### Format choice

The choice between INI and YAML depends on the complexity of the environment and personal preferences. The INI format, with its simplicity, is excellent for fast configurations and less complex inventories. The YAML format, on the other hand, is more suited to complex structures and offers better visibility for more elaborate configurations.

In both cases, static inventories are a powerful tool to explicitly define the desired state of the infrastructure targeted by Ansible automations. They form the basis on which tasks are executed, enabling accurate and predictable management of system configurations.

 ## Dynamic inventories

Unlike static inventories, dynamic inventories are not written manually, but are generated automatically by querying external data sources.

Dynamic inventories allow Ansible to automatically adapt to the infrastructure in real time, which is especially useful in cloud environments where instances can be created or deleted on the fly. Ansible uses scripts or plugins to query external services and build the inventory based on the information collected.

### Dynamic inventories pluging

Ansible supports a wide range of dynamic inventory plugins for different environments and platforms. These plugins allow you to query services such as AWS, Azure, Google Cloud, VMware, Docker and many others. Here is a non-exhaustive list of dynamic inventory plugins available in Ansible:

- AWS EC2 (aws_ec2): To query EC2 instances of Amazon Web Services.
- Azure RM (azure_rm): For Microsoft Azure resources.
- Google Cloud (gcp_compute): For Compute Engine instances of Google Cloud Platform.
- VMware (vmware_vm_inventory): For virtual machines managed by VMware vSphere.
- Docker (docker_container): For Docker containers.
- OpenStack (openstack): For resources in an OpenStack cloud.
- Digital Ocean (digital_ocean): For droplets on Digital Ocean.
- Linode (linode): For Linode instances.
- Oracle Cloud Infrastructure (oci): For resources in Oracle Cloud.
- Kubernetes (k8s): For pods and other resources in a Kubernetes cluster.
