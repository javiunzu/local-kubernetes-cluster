# local-kubernetes-cluster

Use [Vagrant](https://www.vagrantup.com/) to create a set of virtual
machines connected through a virtual network and deploy a Kubernetes
cluster on them.

Vagrant will configure the first VM as cluster master, and the rest
as workers.

Although a local cluster defeats the purpose of Kubernetes itself
(you don't actually get the fail-safe redundancy of a real cluster)
this still has some applications:

* Free training dummy.
* Help cluster admins to test new versions and features of Kubernetes.
* Help in the development of the deployment scripts, which can be later used for example in Terraform.

## Quick start

1. Install Vagrant and Virtualbox.
2. Clone or download this repository.
3. On the directory of the Vagrantfile run:
   
```bash
vagrant up
```

4. Load your configuration:

```bash
export KUBECONFIG="$KUBECONFIG:$PWD/admin.conf"
```

5. Test that everything worked:

```bash
kubectl get nodes
```