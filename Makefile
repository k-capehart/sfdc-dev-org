.PHONY: build open push pull diff

create: 
	sf org create scratch -f config/project-scratch-def.json -a $(ORG) -d -w 30

open: 
	sf org open

push: 
	sf project deploy start

pull: 
	sf project retrieve start

diff: 
	sf project deploy preview
	sf project retrieve preview