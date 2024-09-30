Here's a sample `README.md` for deploying Docusaurus to Azure Container Apps, benchmarked from the Google Cloud Storage version:

---

# 🦄 Deploy Docusaurus to Azure Container Apps

This GitHub Action allows you to deploy a Docusaurus site to Azure Container Apps. It builds your Docusaurus site, creates a Docker image, pushes it to Azure Container Registry (ACR), and deploys it to your Azure Container App.

## Usage

### `main.yml` Example

Place the following code in a `.yml` file, such as `main.yml`, in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: 🦄 Deploy Docusaurus to Azure Container Apps
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
      - uses: docuactions/azure@main
        with:
          azure_credentials: ${{ secrets.AZURE_CREDENTIALS }}
          azure_acr_name: ${{ secrets.ACR_NAME }}
          azure_app_name: ${{ secrets.AZURE_APP_NAME }}
          azure_resource_group: ${{ secrets.AZURE_RESOURCE_GROUP }}
          node_version: '16.x'
```

## Configuration

The following settings must be passed as secrets in your GitHub repository. Sensitive information, especially `AZURE_CREDENTIALS`, should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) to keep them secure.

| Key                | Value                                                     | Suggested Type | Required | Notes |
|--------------------|-----------------------------------------------------------|----------------|----------|-------|
| `azure_credentials` | Your Azure service principal credentials in JSON format.  | `secret env`   | Yes      | [Azure Service Principal Docs](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli) |
| `azure_acr_name`   | Name of the Azure Container Registry (ACR) to push to.     | `secret env`   | Yes      | Example: `myregistry` |
| `azure_app_name`   | Name of your Azure Container App.                          | `secret env`   | Yes      | Example: `my-docusaurus-app` |
| `azure_resource_group` | The resource group where your Azure Container App is hosted. | `secret env`   | Yes      | Example: `my-resource-group` |

## Azure Setup

1. **Create Azure Service Principal**: You need to create an Azure Service Principal and store its credentials as a GitHub secret (`AZURE_CREDENTIALS`). Follow the [official guide here](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli) to create one.
2. **Set up Azure Container Registry (ACR)**: Ensure you have an ACR to store your Docker images. [Learn more about ACR here](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-azure-cli).
3. **Create an Azure Container App**: If you don't have an Azure Container App, [follow this guide to create one](https://docs.microsoft.com/en-us/azure/container-apps/get-started).

## Credits

* [Henry Newman](https://github.com/henrynewman)
