pipeline {
    agent any
    environment {
        IMAGE_REPO_NAME="jenkinsimage"
        IMAGE_TAG="latest"
        REPOSITORY_URI = " gcr.io/mythical-lens-410604"
	GCP_SERVICE_ACCOUNT_CREDENTIALS = credentials('4def1053-0249-4cef-8094-8847cc86101c')
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
                withCredentials([file(credentialsId: '4def1053-0249-4cef-8094-8847cc86101c', variable: 'GCP_SERVICE_ACCOUNT_CREDENTIALS')]) {
                        // Authenticate with Google Cloud using service account credentials
                sh "gcloud auth activate-service-account --key-file=${GCP_SERVICE_ACCOUNT_CREDENTIALS}"
		sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}/${IMAGE_REPO_NAME}:$IMAGE_TAG"""
		sh "gcloud auth configure-docker us-central1-docker.pkg.dev"
                sh """docker push $REPOSITORY_URI/${IMAGE_REPO_NAME}:${IMAGE_TAG}"""
             }
 	   }
        }
      }
    }
}
