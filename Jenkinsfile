

pipeline {

    agent {label "default-docker slave"}
    
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
    }
}