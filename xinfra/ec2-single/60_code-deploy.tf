# CodeDeploy 애플리케이션 생성
resource "aws_codedeploy_app" "istory-app" {
  name = "istory-app"
}

# CodeDeploy 배포 그룹 생성
resource "aws_codedeploy_deployment_group" "istory-deploy_group" {
  app_name               = aws_codedeploy_app.istory-app.name
  deployment_group_name  = "istory-deploy-group"
  service_role_arn      = aws_iam_role.codedeploy_service_role.arn

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Environment"
      type  = "KEY_AND_VALUE"
      value = "Development"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    enabled = false
  }
}

# CodeDeploy 애플리케이션 이름 출력
output "codedeploy_app_name" {
  value       = aws_codedeploy_app.istory-app.name
  description = "Name of the CodeDeploy application"
}

# CodeDeploy 배포 그룹 이름 출력
output "codedeploy_deployment_group_name" {
  value       = aws_codedeploy_deployment_group.istory-deploy_group.deployment_group_name
  description = "Name of the CodeDeploy deployment group"
}