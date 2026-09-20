# Project #11: Internal Document Management & Automation Platform

## 📌 Overview

An internal document management platform based on **Paperless-ngx**, deployed on **Microsoft Azure**.

The project provides a centralized solution for storing, organizing, classifying, and searching business documents while reducing manual document handling and scattered file storage.

## 🎯 Objectives

* Deploy Paperless-ngx on Azure
* Provision infrastructure using **Terraform**
* Automate server setup using **Bash**
* Deploy the application using **Docker Compose**
* Enable document upload, OCR, metadata management, and search
* Provide a repeatable internal document-management environment


## 🛠️ Technologies

* **Paperless-ngx** — Document Management
* **Microsoft Azure** — Cloud Infrastructure
* **Terraform** — Infrastructure as Code
* **Docker & Docker Compose** — Application Deployment
* **Bash** — Automation & Server Configuration
* **Linux** — Host Operating System

## 👥 Target Users

* Operations teams
* Administrative teams
* Finance teams
* Compliance / Records teams
* IT Support

## ✨ Key Features

* Document upload and storage
* OCR processing for scanned documents
* Full-text document search
* Metadata and tagging
* Centralized document archive
* Automated deployment and health checks

## 📂 Project Structure

```text
CC_Paperless-ngx_team01/
│
├── terraform/          # Azure infrastructure
├── scripts/            # Bash automation scripts
├── docker-compose.yml  # Paperless-ngx deployment
├── .env.example        # Environment variables template
├── README.md           # Project documentation
└── docs/               # Additional documentation
```

## 🔐 Security

The deployment should include:

* Restricted access to the application
* Secure application credentials
* Proper Azure network/security rules
* Regular system updates
* Backup and document retention procedures

> **Note:** Never commit real passwords, API keys, SSH keys, or other secrets to the repository.

## 📋 Acceptance Criteria

The project is considered successful when:

* Azure infrastructure is provisioned using Terraform
* Paperless-ngx deploys successfully
* Docker Compose starts the required services
* Documents can be uploaded and processed with OCR
* Documents can be searched and organized
* Deployment and operational documentation is available

## 📄 Project Scope

**In Scope:** Azure infrastructure, Terraform, Bash automation, Docker Compose, Paperless-ngx, OCR, search, metadata, and operational documentation.

**Out of Scope:** Full enterprise records management, complex legal retention policies, and multi-region deployment
