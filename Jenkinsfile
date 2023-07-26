pipeline {
    
    agent any
    tools {
      maven 'maven'
    }
    
    
    stages {
        stage ('checkout') {
            steps{
                git branch: 'main', url: 'https://github.com/zielotechtest/web-app-maven.git'
            }
        }
        
        stage ('Build') {
            steps{
                sh 'mvn clean package checkstyle:checkstyle'
            }
        }
        stage ('Test') {
            steps{
                sh 'mvn test'
            }
        }
        stage ('Code quality analysis') {
            steps{
                recordIssues(tools: [checkStyle()])
            }
        }
        
        stage ('Code Coverage') {
            steps{
                jacoco maximumBranchCoverage: '80', maximumClassCoverage: '80', maximumComplexityCoverage: '80', maximumInstructionCoverage: '80', maximumLineCoverage: '80', maximumMethodCoverage: '80', minimumBranchCoverage: '80', minimumClassCoverage: '80', minimumComplexityCoverage: '80', minimumInstructionCoverage: '80', minimumLineCoverage: '80', minimumMethodCoverage: '80'
            }
        }
        
        stage ('Docker Build and Publish') {
            steps{
                // sh 'docker build -t web .'
                
                withCredentials([usernamePassword(credentialsId: 'DOCKER-CRED', passwordVariable: 'pswd', usernameVariable: 'uname')]) {
                    sh 'docker login -u $uname -p $pswd'
                    // sh 'docker build -t web .'
                    sh 'docker tag web:latest nayakomprasad/demo123:v3'
                    sh 'docker push nayakomprasad/demo123:v3'
                }
                
            }
        }
        stage ('k8s') {
            steps{
                withAWS(credentials:'aws') {
                    withKubeConfig([credentialsId: 'k8s', serverUrl: 'https://6C753EAC71C9CB467D7F83C920526F80.gr7.ap-south-1.eks.amazonaws.com']) {
                        sh '''

                        kubectl get nodes

                        '''

                              // curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                        // sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
                        // chmod +x kubectl
                        // mkdir -p ~/.local/bin
                        // mv ./kubectl ~/.local/bin/kubectl
                      
                    }
                }
            }
        }
        
        
        
    }
}
