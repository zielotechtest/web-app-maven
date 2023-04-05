pipeline {
    agent any

//     tools {
//         // Install the Maven version configured as "M3" and add it to the path.
//         maven "maven"
//     }
    

    stages {
        stage('Checkout') {
            steps {
                echo "checkout"
                //cleanWs()
                // Get some code from a GitHub repository
                // git 'https://github.com/zielotechgroup/maven-webapp.git'
            }
        }
        stage('Build') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package checkstyle:checkstyle"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

        }
        
//         stage('UT'){
//             steps {
//                 junit '**/target/surefire-reports/TEST-*.xml'
//                 archiveArtifacts 'target/*.jar'
//             }
//         }
        
        stage('Static Analysis'){
            steps{
                recordIssues enabledForFailure: true, tools: [checkStyle(pattern: '**/checkstyle-result.xml')]
            }
        }
        
        stage('Code Coverage'){
            steps{
                jacoco maximumBranchCoverage: '80', maximumClassCoverage: '80', maximumComplexityCoverage: '80', maximumInstructionCoverage: '80', maximumLineCoverage: '80', maximumMethodCoverage: '80', minimumBranchCoverage: '80', minimumClassCoverage: '80', minimumComplexityCoverage: '80', minimumInstructionCoverage: '80', minimumLineCoverage: '80', minimumMethodCoverage: '80'
            }
        }
        
        stage('Docker Build'){
            steps{
                sh "echo image built"
//                 sh "docker login -u nayakomprasad -p dckr_pat_-euNNcMJJlM2drsnxHwBo1loAOw"
//                 sh "docker build -t webapp ."
//                 sh "docker tag webapp:latest nayakomprasad/maven-webapp:1.0"
//                 sh "docker push nayakomprasad/maven-webapp:1.0"
            }
        }
      
    }
}
