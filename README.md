# Kubernetes cluster con ansible

Proyecto ansible para crear un cluster de kubernetes que puede ser multimaster o single master.
Fue probado en ambiente testing, en servicios virtualizados y en bare metal

**ACLARACION: hasta el momento todas las pruebas se han hecho siendo ubuntu todos los servidores del cluster.**

<!-- TODO: testear en ambiente CentOS -->

## Requisitos

- `Producción:` solo es necesario contar con `Docker` o `Ansible` (si ven makefile ansible se corre dentro de un
contenedor que cuenta con ansible instalado pero perfectamente podrian ejecutarse los comandos en la pc de desarrollo)
Es recomendable contar con kubectl en la computadora de desarrollo para poder conectarse directo al cluster,
en lugar de establecer conexión a un nodo y desde ahi ejecutar kubectl, esto se recomienda porque la conexión 
externa ya esta con HA etre los diferentes nodos master.

- `Testing:` es necesario contar con:
  - `Docker` o `Ansible`
  - `VirtualBox` u otro motor de virtualizacion
  - `Vagrant`
para el ambiente de test, la configuración de `inventory.yml.example` y `group_vars/all.yml.example` ya esta acorde al archivo vagrant
y es posible levantar el cluster con unos pocos comandos.

## Estructura del proyecto

```bash
├── docs # documentacion extra y guias interesantes que se utilizaron para comprender algunos conceptos claves
├── groups_vars # templates de variables con valores por defecto, desde donde el cluster toma la configuracion basica
├── roles #
│   ├── 
│   ├──
│   .
│   .
│   .
│   └──
├── addon.yml
├── ansible.cfg
├── inventory.yml.example
├── kubectl-get-config.yml
├── Makefile
└── Vagrantfile
```

### Ansible roles

- yum-proxy - installs Squid proxy server - solo neceasrio en caso de usar centOS **(no ha sido verificado)**
- yum-repo - installs epel repo - solo neceasrio en caso de usar centOS **(no ha sido verificado)**
- sslcert - crea todos los certificados ssl necesarios para que el cluster k8s funcione de forma segura
- runtime-env - common settings for container runtime environment
- docker - install latest docker release on all cluster nodes
- containerd - si se quiere usar containerd runtime en lugar de Docker se utiliza este rol - **se debe configurar habilitar en el grupo de variables**
- etcd - instala etcd (base de datos key-value distribuida) cluster, es un pod que corre en todos los nodos master mediante la cual estos se sincronizan
- haproxy - funciona en conjunto con keepalived, haproxy provee un servicio de alta disponibilidad para kube-API, se corre como servicio en todos los nodos master
- keepalived - keepalive se usa para proveer HA de IP address a kube-api server, se corre como servicio en todos los nodos master
- master - instala y configura un nodo k8s-master - `kube-apiserver`, `kube-controller`, `kube-scheduler`, `kubectl` client
- node - instala un nodo k8s-worker - `kubelet`
- addon - crea los addons básicos y normalmente usados en k8s: `flanneld`, `kube-proxy`, `kube-dns`, `dashboard` **se pueden deshabilitar individualmente en el grupo de variables**

**NOTA:** Para correr los addon es necesario que el cluster este completamente levantado, por lo que hay que verificarlo o esperar un tiempo razonable (5 minutos) antes de correr los addon

```bash
ansible-playbook -i inventory addon.yml
```

## Empezando


```bash
git clone https://github.com/ibarretorey/multimaster-k8s-cluster
cd multimaster-k8s-cluster
cp group_vars/all.yml.example group_vars/all.yml # editar todas las variables para su entorno especifico
cp inventory.yml.example inventory.yml # editar las variables para su entorno especifico
ansible-playbook -i inventory cluster.yml
```



## Base teórica y documentación


## Comandos útiles

[Instalar kubectl local]()
[kubectl-autocomplete](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete)
[diagnosticar-red](kubectl run nwtool --image praqma/network-multitool)