pipeline {
    agent any

    parameters {
        string(name: 'REGION', defaultValue: 'us-east-1', description: 'AWS Region')
        string(name: 'ENV', defaultValue: 'test', description: 'Environment (e.g., test, prod)')
    }

    stages {
        stage('Pull GitHub Repo'){
            steps {
                git branch: 'main',
                    url: 'https://github.com/xPl1Cit/aws-engagement-ready-deployment',
                    credentialsId: 'github-token'
            }
        }

		stage('Install Kubectl') {
            steps {
                sh '''
                    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.31.0/bin/linux/amd64/kubectl
                    chmod +x kubectl
                    mkdir -p $HOME/bin
                    mv kubectl $HOME/bin/kubectl
                '''
            }
        }

		stage('Install Terraform') {
            steps {
                sh '''
                    TERRAFORM_VERSION="1.8.5"
					INSTALL_DIR="$HOME/tools"

					mkdir -p "$INSTALL_DIR"
					curl -sSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/terraform.zip
					unzip -o /tmp/terraform.zip -d "$INSTALL_DIR"
					chmod +x "$INSTALL_DIR/terraform"

					export PATH="$INSTALL_DIR:$PATH"

					terraform version
			'''
            }
        }
        
        stage('Provision EKS Cluster') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-credentials',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    sh """
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set region ${params.REGION}
                        aws sts get-caller-identity
                    
						export PATH="$HOME/tools:\$PATH"
						export PATH="$HOME/bin:\$PATH"
						export PATH="$HOME/bin/kubectl:\$PATH"
                        chmod +x ./terraform/deploy-stage.sh
                        ./terraform/deploy-stage.sh ${params.REGION} ${params.ENV}
						chmod +x ./terraform/deploy-db-secret.sh
                        ./terraform/deploy-db-secret.sh ${params.ENV}
                    """
                }
            }
        }
        
        stage('Provision Helper Services') {
			steps {
				script {
					build job: 'Deploy Services',
						  parameters: [
							  string(name: 'REGION', value: "${REGION}"),
							  string(name: 'ENVIRONMENT', value: "${ENV}")
						  ],
						  wait: true
				}
			}
		}
		
		stage('Deploy Images') {
			steps {
				script {
					build job: 'Deploy Product',
						  parameters: [
							  string(name: 'REGION', value: "${REGION}"),
							  string(name: 'VERSION', value: "latest"),
							  string(name: 'DEPLOYMENT_COLOR', value: "blue"),
							  string(name: 'ENVIRONMENT', value: "${ENV}")
						  ],
						  wait: true
				}

				script {
					build job: 'Deploy Cart',
						  parameters: [
							  string(name: 'REGION', value: "${REGION}"),
							  string(name: 'VERSION', value: "latest"),
							  string(name: 'DEPLOYMENT_COLOR', value: "blue"),
							  string(name: 'ENVIRONMENT', value: "${ENV}")
						  ],
						  wait: true
				}
				
				script {
					build job: 'Deploy Angular',
						  parameters: [
							  string(name: 'REGION', value: "${REGION}"),
							  string(name: 'VERSION', value: "latest"),
							  string(name: 'DEPLOYMENT_COLOR', value: "blue"),
							  string(name: 'ENVIRONMENT', value: "${ENV}")
						  ],
						  wait: true
				}
			}
		}
		
		stage('Provision Metrics') {
			steps {
				script {
					build job: 'Deploy Metrics',
						  wait: true
				}
			}
		}

		stage('Provision Cache') {
			steps {
				script {
					build job: 'Deploy Cache',
						  wait: true
				}
			}
		}
    }
}
