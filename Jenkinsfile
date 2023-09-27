pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID =  credentials ('accesskey') // for Terraform 
        AWS_SECRET_ACCESS_KEY  =  credentials ('secretkey') // for Terraform 
        DOCKERHUBUSER = credentials ('dockerhubuser') // This is for docker login to push the image
        DOCKERHUBPSW =  credentials ('dockerhubpsw')
        SERVERKEY = credentials ('server')          // This is pem file which Ansible will take it
    }

    stages {

        stage('build') {
            steps {
                script {
                    sh """
                    cd shoestop
                    sh build.sh
                    """
                }
            }
        }
        stage('push') {
            steps {
                script {
                    sh """
                    cd push
                    sh push.sh
                    """
                }
            }
        }
        stage('vpc-ec2-creation') { // by Terraform 
            steps {
                script {
                    sh """
                    cd create_infra
                    sh config_infra.sh
                    """
                }
            }
        }
        stage('deployment') { // by Ansible
            steps {
                script {
                    sh """
                    cd ansible
                    sh ansible.sh
                    ansible-playbook -i inventory.txt --private-key=$SERVERKEY playbook.yml
                    """
                }
            }
        }
        stage('Alb-Autoscaling-creation') {  // by Terraform 
            steps {
                script {
                    sh """
                    cd load_balancer
                    sh config_alb.sh
                    """
                }
            }
        }
        /*stage('Deleting-infra'){ //  5 minutes time to check for everything like infrastructure after destroy everything using this stage
            steps {
                script {
                    
                    sh """
                    sleep 300
                    cd load_balancer
                    terraform destroy --auto-approve
                    cd ..
                    cd create_infra
                    terraform destroy --auto-approve
                    """
                }
            }
        }*/
    }
}
