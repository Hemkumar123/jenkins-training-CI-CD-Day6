pipeline {
    agent {  label "master"    }
    
    stages {
        // Step 1
        stage('SCM') {
                steps {
                    git 'https://github.com/Hemkumar123/jenkins-training-CI-CD-Day6.git'
                }        
        }
        // Step 2
        stage('Build by Maven') {
                steps {
                    sh 'mvn clean package'
                }
        }
        
        // Step 3
        stage('Build docker image') {
                steps {
                    sh "sudo docker build -t tomcat:9.0:${BUILD_NUMBER} ."
                }
        }
        
        // Step 4
        stage('Push docker image') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "sudo docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
            sh "sudo docker push tomcat:9.0:${BUILD_NUMBER}"
        }
    }
}
        
        // Step 5 
        stage('Deploy Java App in  Dev Env') {
                steps {
                        sh "sudo docker rm -f myjavaappdevenv"
                        sh "sudo docker run -it --rm -p 8888:8080 tomcat:9.0:${BUILD_NUMBER}"
                }
        }
        
        // Step 6  in  Redhat CLI 1 
        stage('Deploy Java in QA/Test Env') {
            steps {
                    // sshagent(['QA_ENV_SSH_CRED']) {
                        // sh "ssh root@192.168.43.229 docker rm -f myjavaapp"
                        // sh "ssh root@192.168.43.229 docker run  -d -p 8080:8080 --name myjavaapp webdevprashant/javaapp-day6:${BUILD_NUMBER}"
            sh "sudo docker rm -f myjavaappqatestenv"            
            sh "sudo docker run -it --rm -p 8888:8080 tomcat:9.0:${BUILD_NUMBER}"           
                    // }
            }
        }
            
        stage('QAT Test') {
            steps {
        	// bcz tomcat take some sec. to display data , so apply some delay here        
                retry(30) {
                    sh 'curl --silent http://172.17.0.1:1223/tomcat:9.0/ |  grep India'
                }   
            }
        }
        
        // Step  in Redhat 8 CLI 2
        stage('Deploy webAPP in Prod Env') {
            steps {
               
            //   sshagent(['QA_ENV_SSH_CRED']) {                    
                        // sh "ssh root@192.168.43.229 docker rm -f myjavaapp"
                        // sh "ssh root@192.168.43.229 docker run  -d -p 8080:8080 --name myjavaapp webdevprashant/javaapp-day6:${BUILD_NUMBER}"                   
                // }
                sh "sudo docker rm -f myjavaappprodenv"
                sh "sudo docker run -it --rm -p 8888:8080 tomcat:9.0:${BUILD_NUMBER}"  
            }
        }
    }
}      
