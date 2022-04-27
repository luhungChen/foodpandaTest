def getHost(){
    def remote = [:]
    remote.name = 'test'
    remote.host = '192.168.0.99'
    remote.user = 'root'
    remote.port = 8081
    remote.password = 'aline0128'
    remote.allowAnyHosts = true
    return remote
}
pipeline {
    agent any
    environment{
           def server = ''
    }
    stages 
    {
        stage('init-server'){
            steps {
                script {                 
                   server = getHost()                                   
                }
            }
        }     
        stage('Build') 
        { 
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
                script {
                  sshCommand remote: server, command: """                 
                      cd /root;touch test.txt;
                  """
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}