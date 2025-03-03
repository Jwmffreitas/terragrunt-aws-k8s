
# Projeto Terragrunt-AWS-K8s

## 🚀 Objetivo

Este projeto tem como objetivo provisionar e operar uma infraestrutura em nuvem utilizando **Infrastructure as Code (IaC)** para o deploy de uma aplicação containerizada. A infraestrutura foi criada com **Terraform** (com o uso de **Terragrunt**), e a aplicação foi empacotada como um contêiner Docker e orquestrada com **Kubernetes**. A infraestrutura foi provisionada na **AWS** e o deploy foi feito no **Amazon Elastic Kubernetes Service (EKS)**.

## 🛠 Requisitos Técnicos

### 1. Infraestrutura na Nuvem

-   **Provedor de Nuvem**: A infraestrutura foi provisionada na **AWS**.
-   **Provisionamento com Terraform**: O código de infraestrutura foi criado utilizando **Terraform** (com suporte a **Terragrunt** para facilitar o gerenciamento de múltiplos ambientes).
-   **Cluster Kubernetes**: Foi configurado um **cluster EKS** na AWS, que orquestra os contêineres.

### 2. Aplicação

-   **Aplicação**: Foi desenvolvida uma aplicação simples em **Node.js** que exibe um "Hello EKS!".
-   **Containerização**: A aplicação foi empacotada em um contêiner **Docker**. O `Dockerfile` utilizado para construir a imagem Docker está incluído no repositório.
-   **Deploy com Helm**: O deploy da aplicação foi feito utilizando **Helm**, uma ferramenta de Kubernetes que facilita o gerenciamento de pacotes.

### 3. Rede e Segurança

-   **Segurança e Firewall**: O acesso à aplicação foi configurado por meio de **Security Groups** da AWS, permitindo o tráfego nas portas 80 (HTTP) e 443 (HTTPS).
-   **IAM Roles**: Foi configurado um **IAM Role** para o acesso adequado ao EKS e a autenticação da aplicação.
-   **Exposição para a Internet**: A aplicação foi exposta para a internet através de um **LoadBalancer** no serviço Kubernetes.

## 🌐 Arquitetura Utilizada

A infraestrutura provisionada segue a arquitetura abaixo:

1.  **VPC (Virtual Private Cloud)**: A infraestrutura foi configurada em uma VPC com sub-redes públicas e privadas para suportar o acesso da aplicação.
2.  **EKS Cluster**: Um cluster Kubernetes foi provisionado no EKS com dois nós EC2 em uma **auto-scaling group**.
3.  **IAM Roles**: O EKS foi configurado com permissões adequadas para o acesso à VPC e outros serviços.
4.  **Security Groups**: Foram configuradas regras de segurança para permitir o tráfego HTTP da internet (porta 80).
5.  **Load Balancer**: A aplicação foi exposta para a internet via um Load Balancer configurado no Kubernetes.
6. **Amazon ECR**: O **Elastic Container Registry (ECR)** foi utilizado para armazenar as imagens Docker. A imagem da aplicação foi construída localmente e enviada para o repositório ECR, sendo posteriormente utilizada pelo Kubernetes para o deploy da aplicação.

## 📜 Estrutura do Projeto

A estrutura do repositório está organizada da seguinte forma:

```
application/
  ├── Dockerfile          # Arquivo Docker para construir a imagem da aplicação
  ├── index.js            # Código da aplicação Node.js
  └── package.json        # Dependências e scripts da aplicação

terraform/
  ├── environment/        # Infraestrutura por ambiente (ex: dev, prod, etc.)
  │   ├── dev/            # Ambiente de desenvolvimento
  |   |   ├── eks/        # Arquivos de configuração terragrunt      
  |   │   │   ├── terragrunt.hcl 
  |   |   ├── vpc/        # Arquivos de configuração terragrunt      
  |   │   │   ├── terragrunt.hcl 
  |   |   ├── ecr/        # Arquivos de configuração terragrunt      
  |   │   │   ├── terragrunt.hcl 
  │   │   └── root.hcl    # Arquivo root.hcl para configuração global
  │   └── prod/           # Ambiente de produção (se necessário)
  |   |   ├── eks/        # Arquivos de configuração terragrunt      
  |   │   │   ├── terragrunt.hcl 
  |   |   ├── vpc/        # Arquivos de configuração terragrunt      
  |   │   │   ├── terragrunt.hcl 
  |   |   ├── ecr/        # Arquivos de configuração terragrunt      
  |   │   │   ├── terragrunt.hcl 
  │       └── root.hcl
  └── modules/            # Módulos Terraform reutilizáveis
      ├── eks/            # Módulo para provisionar o cluster EKS
      ├── vpc/            # Módulo para configurar a VPC
      └── ecr/            # Módulo para configurar o repositório ECR
helm/
  └── hello-eks/          # Chart Helm para a aplicação Node.js
      ├── Chart.yaml      # Informações do chart (nome, versão, etc.)
      ├── values.yaml     # Arquivo de valores para personalizar o chart
      ├── templates/      # Templates Kubernetes (Deploy, Service, etc.)
      │   ├── deployment.yaml
      │   ├── service.yaml
      │   └── hpa.yaml
```

## 📦 Instruções de Deploy

1.  **Clonar o Repositório**: Clone este repositório para sua máquina local:
    
    ```bash
    git clone https://github.com/Jwmffreitas/terragrunt-aws-k8s
    cd terragrunt-aws-k8s    
    ```
    
2.  **Configurar as Variáveis**: Edite os arquivos `.hcl` na pasta `environments/dev/*` para incluir os valores específicos para o seu ambiente (ex: `region`, `backend`, etc.).
    
3.  **Iniciar o Terragrunt**: Na pasta do ambiente (ex: `environments/dev/`), execute os seguintes comandos para inicializar o Terraform e aplicar a infraestrutura:
    
    ```bash
    terragrunt run-all init
    terragrunt run-all apply    
    ```    
6.  **Acessar a Aplicação**: Após a aplicação do terragrunt, a aplicação estará acessível publicamente através do Load Balancer. O endereço pode ser obtido com o comando:
    
    ```bash
    kubectl get svc hello-eks --namespace default    
    ```
    
    A URL do serviço será exibida na coluna **EXTERNAL-IP**.
    

## 🔧 Ferramentas Utilizadas

-   **Terraform**: Para provisionamento da infraestrutura como código.
-   **Terragrunt**: Para gerenciamento de múltiplos ambientes de maneira eficiente.
-   **AWS EKS**: Para orquestrar a aplicação utilizando Kubernetes.
-   **Docker**: Para containerizar a aplicação.
-   **Helm**: Para gerenciar e facilitar o deploy da aplicação no Kubernetes.

## 📈 Monitoramento e Logs

Para verificar os logs da aplicação em Kubernetes, utilize o comando:

```bash
kubectl logs <POD_NAME> -n default
```

Para verificar o status do deployment:

```bash
kubectl get all -n default
```