void setBuildStatus(String message, String state) {
  step([
      $class: "GitHubCommitStatusSetter",
      reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/my-org/my-repo"],
      contextSource: [$class: "ManuallyEnteredCommitContextSource", context: "ci/jenkins/build-status"],
      errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
      statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
  ]);
}
pipeline {
    agent {
        docker {
            image 'maven:3.6.3-jdk-11' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    environment {
        COMPONENT = 'master'
        AWS_ECR_ID = '065307277436'
    }
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
        stage('Push to ECR') {
            steps {
                    sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $AWS_ECR_ID.dkr.ecr.us-east-2.amazonaws.com/$COMPONENT'
                    sh 'docker build . -t $COMPONENT'
                    sh 'docker tag $COMPONENT:latest $AWS_ECR_ID.dkr.ecr.us-east-2.amazonaws.com/$COMPONENT:latest'
                    sh 'docker push $AWS_ECR_ID.dkr.ecr.us-east-2.amazonaws.com/$COMPONENT:latest'
                }
            }
        }
    }
    post {
        success {
            setBuildStatus("Build succeeded", "SUCCESS");
        }
        failure {
            setBuildStatus("Build failed", "FAILURE");
        }
    }
}
