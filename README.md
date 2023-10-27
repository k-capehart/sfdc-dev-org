
# sfdc-dev-org
Personal SFDC Dev Org for testing configuration and code
=======
# Prerequisites
- Dowload SF CLI with npm: `npm install @salesforce/cli --global`
    - More information: https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm#sfdx_setup_install_cli_macos
    - Moving from SFDX CLI to SF CLI: https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_move_to_sf_v2.htm
- Install Salesforce VS Code Extensions: https://developer.salesforce.com/tools/vscode

# First Time Setup
- Authenticate in Salesforce environment
    - `sfdx-dev-org % sf org login web -a prod -d -r [production url]`
    - `sfdx-dev-org % sf org login web -a stage -r [full sandbox url]`

# Setup Scratch Org
Scratch Orgs are temporary Salesforce environments that are used for development. They are spun up based on a configuration file and contain no metadata upon creation.
- Create a Scratch Org: `sf org create scratch -f config/project-scratch-def.json -a [alias] -d -w 30`
- Open default org: `sf org open`
- Push local metadata to org: `sf project deploy start`
    - Ideally, you'll do this during setup to get all metadata from sfdc repo into the scratch org

# sf cli commands
[link to documentation]

# Deploy to Sandbox and Production
- .github/workflows/main.yml validates the package when a PR is opened
- .github/workflows/release.yml deploys the package when a Release is published
- Salesforce authorization URL is stored in: SFDX_INTEGRATION_URL
