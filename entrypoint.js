const exec = require('child_process').execSync;
const core = require('@actions/core');

async function run() {
  try {
    // Get input values
    const azureCredentials = core.getInput('azure_credentials');
    const acrName = core.getInput('azure_acr_name');
    const appName = core.getInput('azure_app_name');
    const resourceGroup = core.getInput('azure_resource_group');
    const nodeVersion = core.getInput('node_version');

    // Azure login
    exec(`echo '${azureCredentials}' | az login --service-principal --tenant <tenant-id> --allow-no-subscriptions`);

    // Build and push Docker image to Azure ACR
    exec(`az acr login --name ${acrName}`);
    exec(`docker build -t ${acrName}.azurecr.io/docusaurus-app:${process.env.GITHUB_SHA} .`);
    exec(`docker push ${acrName}.azurecr.io/docusaurus-app:${process.env.GITHUB_SHA}`);

    // Deploy to Azure Container App
    exec(`az containerapp update --name ${appName} --resource-group ${resourceGroup} --image ${acrName}.azurecr.io/docusaurus-app:${process.env.GITHUB_SHA}`);
    
    core.setOutput("status", "Deployment successful");
  } catch (error) {
    core.setFailed(`Action failed with error: ${error.message}`);
  }
}

run();
