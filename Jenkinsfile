pipeline {
    agent any

    stages {
        stage('Build') 
        {    
            sh "mvn package"
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}