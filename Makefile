.PHONY: start scratch push pull diff test scan apex_trigger
TIMESTAMP := $(shell date +%s)
DEVHUB := devHub # update to be the alias of your dev hub that scratch orgs will be created from

# attempt to open a scratch org with the given alias, or the current default one if none is given
# if it fails then try to create a new scratch org
start:
	@if [ ! -z $(NAME) ]; then \
		if ! sf org open -o $(NAME) ; then \
			echo 'creating scratch org'; \
			make scratch; \
		fi \
	else \
		if ! sf org open; then \
			echo 'creating scratch org'; \
			make scratch; \
		fi \
	fi

# create a scratch org with a given name or default name if none is given
# if scratch org creation fails, then create an org shape and then try again
# example: $ make create_scratch NAME=new-scratch-org
scratch:
	@if [ ! -z $(NAME) ]; then \
		if ! sf org create scratch -f config/project-scratch-def.json -a $(NAME) -d -w 30; then \
			echo 'creating org shape'; \
			if sf org create shape -o $(DEVHUB); then \
				sf org create scratch -f config/project-scratch-def.json -a $(NAME) -d -w 30; \
			fi \
		fi \
	else \
		if ! sf org create scratch -f config/project-scratch-def.json -a "org-$(TIMESTAMP)" -d -w 30; then \
			echo 'creating org shape'; \
			if sf org create shape -o $(DEVHUB); then \
				sf org create scratch -f config/project-scratch-def.json -a "org-$(TIMESTAMP)" -d -w 30; \
			fi \
		fi \
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
	@sf apex run test --test-level RunLocalTests --code-coverage -r human -d test-results/ -w 30

scan:
	@if ! sf scanner run -e pmd -t . -f html -o scan-results/code-scan.html --severity-threshold 2; then \
		echo 'creating directory: scan-results/'; \
		mkdir scan-results/; \
		sf scanner run -e pmd -t . -f html -o scan-results/code-scan.html --severity-threshold 2; \
	fi

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