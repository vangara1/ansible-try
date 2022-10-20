pipeline {
    agent any
    stages {
        stage("copy ansible files") {
            steps {
                script {
                    echo "copying all files"
                    sshagent(['ansible-key']){
                        sh "scp -o StrictHostKeyChecking=no ansible/* root@52.90.226.1:/root "
                        withCredentials([sshUserPrivateKey(credentialsId: 'centos-key', keyFileVariables: 'keyfile', usernameVariable: 'user')])
                          sh "scp ${keyfile} root@52.90.226.1:/root/ssh-key.pem  "
                    }
                }
            }
        }
    }   
}