pipeline {
    agent any
    environment {
        IMAGE_REPO_NAME="jenkinsimage"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "us-central1-docker.pkg.dev/mythical-lens-410604"
    }
   
    stages {
        
         stage('Authendicating the GCP') {
            steps {
                script {
                sh "gcloud auth configure-docker us-central1-docker.pkg.dev"
                }
                 
            }
        }
        
 //       stage('Cloning Git') {
   //         steps {
     //           checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sd031/aws_codebuild_codedeploy_nodeJs_demo.git']]])     
       //     }
        //}
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          sh "docker build -t jenkinsimage . "
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}/${IMAGE_REPO_NAME}:$IMAGE_TAG"""
		sh "gcloud auth configure-docker us-central1-docker.pkg.dev"
                sh """docker push $REPOSITORY_URI/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
         }
        }
      }
    }
}
