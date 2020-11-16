def terraform_version = "0.13.5"
def terraform_url = "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip"
def terraform_zip_path= "./terraform.zip"
// def ret = "sh(script: 'ls && pwd', returnStdout: true)"
pipeline {
    agent { label "automation-docker-slave" }

    parameters {
        booleanParam(name: 'Refresh', defaultValue: false, description: 'Read Jenkinsfile and exit.')
        // choice(choices: ['CREATE', 'DESTROY'], description: 'Create a Kubernetes cluster or destroy one?', name: 'Action')
        // string(description: 'Create a deployment ID. You will need this later to destroy the cluster.', name: 'deploymentID', defaultValue: 'neito-k8s-cluster')
        // choice(choices: ['yes', 'no'], name: 'destroyAtStart', description: 'if CREATE, do you want to destroy previous instance with the given deploymentID first ?')
        // string(description: 'Pick the number of K8s Worker nodes.', name: 'workerCount', defaultValue: '2')
    }
    environment {
        PATH = "${workspace}:$PATH"
    }

    stages {
        stage('Read Jenkinsfile') {
            when {
                expression { return params.Refresh == true }
                // equals expected: true, actual: "${params.Refresh}" 

            }
            steps {
                echo("Read Jenkinsfile to refresh properties.")        
            }
        }
        stage('Run Jenkinsfile') {
            when {
                // equals expected: false, actual: "${params.Refresh}"
                expression { return params.Refresh == false }
            }
            stages { 
                stage ('Apply terraform') { 
                    steps {
                        sh "cd terraform_dir"
                        sh "terraform init"
                    }
                }
            }
        }

    }
}