.PHONY: create open push pull diff test

create: 
	sf org create scratch -f config/project-scratch-def.json -a $(ORG) -d -w 30

open: 
	sf org open

push: 
	sf project deploy start --ignore-conflicts

pull: 
	sf project retrieve start --ignore-conflicts

diff: 
	sf project deploy preview
	sf project retrieve preview --concise

test:
	sf apex run test --test-level RunLocalTests -y -w 30