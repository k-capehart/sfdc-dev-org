.PHONY: start scratch push pull diff test apex_trigger
TIMESTAMP := $(shell date +%s)
DEVHUB := devHub # update to be the alias of your dev hub that scratch orgs will be created from

# attempt to open the current default org
# if it fails then try to create a new scratch org
# if that fails, then create org shape and try again
start:
	@if ! sf org open ; then \
		if ! sf org create scratch -f config/project-scratch-def.json -a "org-$(TIMESTAMP)" -d -w 30; then \
			sf org create shape -o $(DEVHUB); \
			sf org create scratch -f config/project-scratch-def.json -a "org-$(TIMESTAMP)" -d -w 30; \
			sf org open; \
		fi \
	fi

# create a scratch org with a given name, if not given then give a default name
# example: $ make create_scratch NAME=new-scratch-org
scratch:
	@if [ ! -z $(NAME) ]; then \
		sf org create scratch -f config/project-scratch-def.json -a $(NAME) -d -w 30; \
	else \
		sf org create scratch -f config/project-scratch-def.json -a "org-$(TIMESTAMP)" -d -w 30; \
	fi; \
	sf org open;

push: 
	@sf project deploy start --ignore-conflicts

pull: 
	@sf project retrieve start --ignore-conflicts

diff: 
	@sf project deploy preview --concise
	@sf project retrieve preview --concise

test:
	@sf apex run test --test-level RunLocalTests -y -w 30

# given a list of comma separated salesforce objects, create an apex trigger, a handler class, a helper class, and a custom settings
# example: $ make apex_trigger TARGET="Account,Contact,Opportunity"
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