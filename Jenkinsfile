pipeline {
    agent { node { label 'worker' } }

    environment {
        ECRREPOSITORY = "097084951758.dkr.ecr.us-east-1.amazonaws.com/web"
        ECRREGION = "us-east-1"
        EKSCLUSTERNAME = "l124-dp-Cluster"
        DOCKERFILEPATH = "./Dockerfile"
        IMAGETAG = "latest"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${ECRREPOSITORY}:${IMAGETAG} -f ${DOCKERFILEPATH} ."
            }
        }

        stage('Push to Amazon ECR') {
            steps {
                    sh "aws ecr get-login-password --region ${ECRREGION} | docker login --username AWS --password-stdin ${ECRREPOSITORY}"
                    sh "docker push ${ECRREPOSITORY}:${IMAGETAG}"
            }
        }
        
        stage('Update kubeconfig') {
            steps {
                    sh "aws eks --region us-east-1 update-kubeconfig --name l124-dp-Cluster"
            }
        }
        
        stage('Delete old app') {
            steps {
                    sh "kubectl delete -f deployment.yaml"
            }
        }
        stage('Deploy app') {
            steps {
                    sh "kubectl apply -f deployment.yaml"
            }
        }
    }
}
