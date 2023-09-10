# samcart-devops-assessment
 Repo for Samcart  DevOps Test

 Features Included:
  - Python Application for Slack Based Confluence bot
  - Kubernetes Infra
  - AWS Account Infra - via Terraform
    - Account creation via Terraform using AWS Organisations
  - Github Actions Workflows for both Terraform and K8s 
    - Keyless integration with AWS via OIDC
    - Secrets all stored in Github so they are not exposed

Improvements Planned:
  - IAM Related aspects also fully on IAC
  - Key generation is automatic, as well as storage
  - Cleaner solution for K8s (ArgoCD and Helm Charts) 
    - Note: Not included since don't have the tools personally/locally


