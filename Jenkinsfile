pipeline {
    agent any

    stages {
        
        stage('Build') 
        { 
           agent any
           tools {
             maven 'Maven 3.8.5'
           }   
           steps {
             sh "mvn package"
             echo 'Building..'
           }
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