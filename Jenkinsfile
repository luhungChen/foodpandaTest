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
        stage('init-ssh-server'){
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
        stage('put war') {
            steps {
                script 
                {
                  sshPut remote: server, from: 'target/foodpandatest-0.0.1-SNAPSHOT.war', into: '/root/jar/foodpandatest.war'
                }
            }
        }
        stage('Deploy') {
            steps {
               sshCommand remote: server, command: """             
                      nohup sh /root/jar/test.sh >/dev/null &; 
                      
               """
            }
        }
    }
}