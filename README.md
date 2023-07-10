# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

To setup this project asap you can install the unlocked package version using:

sfdx force:package:install --wait 10 --publishwait 10 --package vehicleinformation@1.0.0-1 -k vehicle1234 -r -u yourTargetOrgAlias

or you can install the unlocked package using your org url https://MyDomainName.lightning.force.com//packagingSetupUI/ipLanding.app?apvId=04t5e000000zTnjAAE

You can check the latest version name or id on sfdx-projec.json

You can load some data using the data import wizard. There is a csv file called data/vehicle_file.csv for this purpose.

You all set.

Happy testing!

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
