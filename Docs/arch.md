# Architecture

![My project architecture](./images/Architecture.png)

The project infrastructure was provisioned on Microsoft Azure using Terraform, with all resources managed within a single Resource Group. A Virtual Network (VNet) and Subnet were created to provide a private network for the resources. A Network Interface (NIC) was configured to connect the virtual machine to the network, with a static Public IP address attached to allow remote access to the VM. A Network Security Group (NSG) was also associated with the NIC to control inbound traffic through security rules. Finally, a Linux virtual machine was created and connected to the NIC.

After the infrastructure was provisioned, we accessed the virtual machine through SSH and installed Docker and Docker Compose. Paperless-ngx was then deployed using Docker Compose, providing a centralized platform for document storage, organization, search, and OCR processing to make text in scanned documents searchable.
