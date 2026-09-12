# App Identity

Each app identity bootstraps the required things to start creating projects:

- A workload identity provider, bound to an HCP project
- A service account for the app, bound to an HCP project
    - The service account can create projects for the specified organization
    - The service account can link billing accounts for the specified billing account
