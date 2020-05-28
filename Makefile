create_ssh_key:
	ssh-keygen -b 2048 -t rsa -f ssh-key -q -N ""

vagrant_deploy:
	vagrant up
	docker run --rm -it -v $(shell pwd):/playbooks -w /playbooks ibarretorey/nwtools ansible-playbook -i inventory.yml cluster.yml

vagrant_addon:
	docker run --rm -it -v $(shell pwd):/playbooks -w /playbooks ibarretorey/nwtools ansible-playbook -i inventory.yml cluster.yml

kubectl_config:
	docker run --rm -it -v $(shell pwd):/playbooks -w /playbooks ibarretorey/nwtools ansible-playbook -i inventory.yml kubectl-get-config.yml

vagrant_tear_down:
	vagrant destroy -f

get_all_pods_example:
	kubectl --kubeconfig=./kubectl-config/kubeadminconfig get pods -o wide --all-namespaces