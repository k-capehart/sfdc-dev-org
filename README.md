
# sfdc-dev-org
SFDC Dev Org for testing configuration and code
=======
# Prerequisites
- Dowload SF CLI with npm: `npm install @salesforce/cli --global`
    - More information: https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm#sfdx_setup_install_cli_macos
    - Moving from SFDX CLI to SF CLI: https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_move_to_sf_v2.htm
- [VS Code Salesforce Extension Pack](https://developer.salesforce.com/tools/vscode)
- [Java Setup for VS Code](https://developer.salesforce.com/tools/vscode/en/vscode-desktop/java-setup)
    - [Java JDK Download](https://www.oracle.com/java/technologies/downloads/#jdk21-mac)
 
# Create scratch org
Scratch Orgs are temporary Salesforce environments that are used for development. They are spun up based on a configuration file and contain no metadata upon creation.
- Authenticate Salesforce environment (devhub): `sf org login web -a [alias] -d -r [url]`
- Create a Scratch Org: `make create ORG=[alias]` OR `sf org create scratch -f config/project-scratch-def.json -a [alias] -d -w 30`
- Open default org: `make open` OR `sf org open`
- Push local metadata to org: `make push` OR `sf project deploy start`
    - Ideally, you'll do this during setup to get all metadata from sfdc repo into the scratch org

# Validate and Deploy
- .github/workflows/main.yml validates the package when a PR is opened
- .github/workflows/release.yml deploys the package when a Release is published
- Salesforce authorization URL is stored in: SFDX_AUTH_URL

# Trigger Framework
- Implements trigger framework from https://github.com/kevinohara80/sfdc-trigger-framework
- Modified to include additional virtual methods
    - `isDisabled()`: Runs before trigger context methods, and skips if trigger is disabled. Implemented through Custom Settings.
    - `applyDefaults()`: Executes before beforeInsert().
    - `validate()`: Exectutes before afterInsert() and afterUpdate().

# Makefile
| Command | Description|
| :-------------------------- | :----------------------|
| `make create ORG=[alias]` | Make scratch org.
| `make open` | Open default org.
| `make push` | Deploy local changes.
| `make pull` | Retrieve changes from org.
| `make diff` | Display diff between local and org.
| `make test` | Run apex tests and wait for result.

# sf cli commands
| Command                   | Description                    |
| :------------------------ | :------------------------- |
| `sf org open`	            | Open your default org in a browser.
| `sf project deploy preview` | Preview a deployment to see what will deploy to the org, the potential conflicts, and the ignored files.      
| `sf project retrieve preview` | Preview a retrieval to see what will be retrieved from the org, the potential conflicts, and the ignored files.
| `sf project deploy start`	| Deploy source to an org.
| `sf project retrieve start`	| Retrieve source from an org.
| `sf project deploy validate` | Validate a metadata deployment without actually executing it.
| `sf search`	                | Search for a command.
| `sf scanner run`	        | Scan a codebase with a selection of rules
| `sf org create shape`	    | Create a scratch org configuration (shape) based on the specified source org.
| `sf org login web`	        | Log in to a Salesforce org using the web server flow.
| `sf org create scratch`     | Create a scratch org.
| `sf org display`           | Display information about an org. Use --verbose to display the sfdxAuthUrl property.
| `sf auth sfdxurl store`     | Authorize an org using a Salesforce DX authorization URL stored in a file.
| `sf apex run test` | Invoke Apex tests in an org.
