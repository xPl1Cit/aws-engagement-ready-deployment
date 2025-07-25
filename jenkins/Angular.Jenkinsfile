pipeline {
    agent any
    
    environment {
        PATH = "${env.HOME}/bin:$PATH"
    }

    parameters {
        string(name: 'REGION', defaultValue: 'us-east-1', description: 'AWS Region')
        string(name: 'VERSION', defaultValue: 'latest', description: 'Build version')
        string(name: 'DEPLOYMENT_COLOR', defaultValue: 'blue', description: 'Blue Green Deployment Model')
        string(name: 'ENVIRONMENT', defaultValue: 'test', description: 'Environment (e.g., test, prod)')
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

        stage('Provision Pod') {
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
                        
                        aws eks update-kubeconfig --region ${params.REGION} --name aws-final-al-${params.ENVIRONMENT}
                    
                        chmod +x ./k8s/deploy-pods.sh
                        ./k8s/deploy-pods.sh ${params.REGION} ${params.VERSION} ${params.DEPLOYMENT_COLOR} ${params.ENVIRONMENT} angular
                    """
                }
            }
        }
    }
}
