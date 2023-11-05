pipeline{
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/zielotechtest/web-app-maven.git'
            }
        }
        stage('build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('test'){
            steps{
                sh 'mvn test'
            }
        }
        stage('sonar analysis'){
            steps{
                withSonarQubeEnv('sonar-server'){
                    sh 'mvn sonar:sonar -Dsonar.projectKey=webapp -Dsonar.projectName='webapp''
                }   
            }
        }
        stage('code quality analysis'){
            steps{
                sh 'mvn checkstyle:checkstyle'
                recordIssues(tools: [checkStyle()])
            }
        }
        stage('code coverage'){
            steps{
                jacoco maximumBranchCoverage: '80', maximumClassCoverage: '80', maximumComplexityCoverage: '80', maximumInstructionCoverage: '80', maximumLineCoverage: '80', maximumMethodCoverage: '80', minimumBranchCoverage: '70', minimumClassCoverage: '70', minimumComplexityCoverage: '70', minimumInstructionCoverage: '70', minimumLineCoverage: '70', minimumMethodCoverage: '70'
            }
        }
        stage('docker build & push'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'DOCKER-CRED', passwordVariable: 'password', usernameVariable: 'uname')]) {
                sh 'docker build -t web .'
                sh 'docker tag web rameshkumarverma/web'
                sh 'docker push rameshkumarverma/web'
                }
            }
        }
    }
}
