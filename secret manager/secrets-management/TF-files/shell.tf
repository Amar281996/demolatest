terraform {
  
  required_version = "> 0.8.0"
}
resource "null_resource" "eks_config" {
  
  provisioner "local-exec" {
          command = "aws eks --region us-east-2 update-kubeconfig --name eks --profile default"
          }
}

resource "null_resource" "ASCP_deployment" {

  provisioner "local-exec" {
    command = "kubectl apply -f ../My_service --recursive"
  }
  
}
resource "null_resource" "pod_deploy" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../templet/redis.yaml"
  }
}
resource "null_resource" "copyfile" {
  provisioner "local-exec" {
    command = "kubectl cp ../email.txt test-email:/tmp"
    }
}
resource "null_resource" "copy_files" {
  provisioner "local-exec" {
    command = "kubectl cp ../event.txt test-events:/tmp"
  }
}


resource "null_resource" "file_verfication" {
  provisioner "local-exec" {
    command = "kubectl exec -it test-email -- cat /tmp/email.txt"
  }
}



resource "null_resource" "csi_installation" {
  provisioner "local-exec" {
    command = "kubectl get csidrivers.storage.k8s.io"
    
  }
}





