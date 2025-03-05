# Random Joke Generator - Flask WebApp 🚀🔥

## Project Overview  
This project is a **Flask-based web application** that generates random jokes for users. The web application is deployed on **AWS EKS (Elastic Kubernetes Service)** and features a **CI/CD pipeline** to automate deployment using **AWS CodePipeline and CodeBuild**. The pipeline ensures that any update to the GitHub repository automatically triggers a build, pushes a new Docker image to **AWS ECR**, and deploys the latest version on **EKS** after manual approval.  

---

## Features  

🐍 **Flask WebApp** - Serves a responsive HTML page with a joke generator.  
☸️ **AWS EKS Deployment** - Runs on a scalable Kubernetes cluster.  
🔗 **Automated CI/CD Pipeline** - Uses **AWS CodePipeline & CodeBuild** for continuous integration and continuous deployment.  
✅ **Manual Approval Stage** - Prevents unintended deployments by requiring **manual confirmation** via **SNS email**.  
🐳 **Dockerized Application** - Uses **AWS ECR** for container image storage.  
🔐 **IAM and Secure Secrets Management** - Uses **AWS IAM Roles** to manage permissions and **AWS Systems Manager Parameter Store** to manage secrets.
📧 **SNS Notifications** - Sends email alerts for **deployment status**.  

---

## Deployment Pipeline Workflow 🔄  

### Step 1: Code Push to GitHub  
- Any code update in GitHub triggers **AWS CodePipeline**.  

### Step 2: Manual Approval Stage  
- An **SNS notification** is sent, requiring **manual approval** before proceeding.  

### Step 3: Docker Build & Push to ECR  
- **AWS CodeBuild** builds the Docker image and pushes it to **AWS ECR**.  
- Uses `buildspec.yml` with **parameter-store** to securely fetch credentials.  

### Step 4: Deploy on EKS  
- **CodeBuild** pulls the latest image from ECR and deploys it on the EKS cluster using `eks_buildspec.yml`.  
- Uses `eks_deployment_build/deployment.yml` to deploy changes.  
- Ensures seamless **rolling updates** with zero downtime.  

### Step 5: Deployment Completion Notification  
- SNS notification is sent indicating **success or failure** of the deployment.  

---

## Technology Stack  

### Frontend & Backend  
- **Flask** (Python-based web framework)  
- **HTML, CSS** (For UI)  

### Containerization & Orchestration  
- **Docker** (Containerization)  
- **Amazon ECR** (Docker image storage)  
- **Amazon EKS** (Managed Kubernetes service)  
- **Kubernetes** (For deploying and managing workloads)  

### CI/CD & Infrastructure  
- **AWS CodePipeline** (Continuous Deployment)  
- **AWS CodeBuild** (Build & Deployment)  
- **AWS IAM** (Access Management)  
- **AWS Systems Manager Parameter Store** (Secret Management)  
- **AWS EventBridge** (For triggering SNS notifications)  
- **Amazon SNS** (For notifications)  
- **Amazon Cloudwatch** (For monitoring and logging)
- **Amazon EC2** (For compute)  

---



