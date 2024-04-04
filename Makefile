.PHONY: create open push pull diff test apex_trigger

create: 
	@sf org create scratch -f config/project-scratch-def.json -a $(ORG) -d -w 30

open: 
	@sf org open

push: 
	@sf project deploy start --ignore-conflicts

pull: 
	@sf project retrieve start --ignore-conflicts

diff: 
	@sf project deploy preview --concise
	@sf project retrieve preview --concise

test:
	@sf apex run test --test-level RunLocalTests -y -w 30

apex_trigger:
	@if [ ! -z $(TARGET) ]; then \
		for sobj in $$(echo $(TARGET) | tr ',' '\n'); \
		do \
			sf apex generate trigger -n $$sobj"Trigger" -d force-app/main/default/triggers -s $$sobj -e "before update, before insert, before delete, after update, after insert, after delete, after undelete"; \
			sf apex generate class -n $$sobj"TriggerHandler" -d force-app/main/default/classes -t DefaultApexClass; \
			sf apex generate class -n $$sobj"TriggerHelper" -d force-app/main/default/classes -t DefaultApexClass; \
			sf apex generate class -n $$sobj"TriggerHelper_Test" -d force-app/main/default/classes -t ApexUnitTest; \
			./create_field.exp $$sobj; \
		done \
	fi