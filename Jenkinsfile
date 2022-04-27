pipeline {
    agent any

    stages {
        agent any
        tools {
          maven 'Maven 3.8.5'
        }
        stage('Build') 
        {    
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