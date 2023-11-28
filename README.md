
# sfdc-dev-org
Personal SFDC Dev Org for testing configuration and code
=======
# Prerequisites
- Dowload SF CLI with npm: `npm install @salesforce/cli --global`
    - More information: https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm#sfdx_setup_install_cli_macos
    - Moving from SFDX CLI to SF CLI: https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_move_to_sf_v2.htm
- [Java JDK](https://www.oracle.com/java/technologies/downloads/#jdk21-mac)
- [VS Code Salesforce Extension Pack](https://developer.salesforce.com/tools/vscode)

# First Time Setup
- [Java Setup](https://developer.salesforce.com/tools/vscode/en/vscode-desktop/java-setup)
- Authenticate in Salesforce environment
    - `sf org login web -a [alias] -d -r [url]`

# Setup Scratch Org
Scratch Orgs are temporary Salesforce environments that are used for development. They are spun up based on a configuration file and contain no metadata upon creation.
- Create a Scratch Org: `sf org create scratch -f config/project-scratch-def.json -a [alias] -d -w 30`
- Open default org: `sf org open`
- Push local metadata to org: `sf project deploy start`
    - Ideally, you'll do this during setup to get all metadata from sfdc repo into the scratch org

# Validate and Deploy
- .github/workflows/main.yml validates the package when a PR is opened
- .github/workflows/release.yml deploys the package when a Release is published
- Salesforce authorization URL is stored in: SFDX_AUTH_URL

# sf cli commands
| Command                   | Description                    |
| :------------------------ | :----------------------------- |
| sf org open	            | Open your default org in a browser.
| sf project deploy preview | Preview a deployment to see what will deploy to the org, the potential conflicts, and the ignored files.      
| sf project retrieve preview | Preview a retrieval to see what will be retrieved from the org, the potential conflicts, and the ignored files.
| sf project deploy start	| Deploy source to an org.
| sf project retrieve start	| Retrieve source from an org.
| sf project deploy validate| Validate a metadata deployment without actually executing it.
| sf search	                | Search for a command.
| sf scanner run	        | Scan a codebase with a selection of rules
| sf org create shape	    | Create a scratch org configuration (shape) based on the specified source org.
| sf org login web	        | Log in to a Salesforce org using the web server flow.
| sf org create scratch     | Create a scratch org.
| sf org display            | Display information about an org. Use --verbose to display the sfdxAuthUrl property.
| sf auth sfdxurl store     | Authorize an org using a Salesforce DX authorization URL stored in a file.
