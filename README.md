## 1. 배포 절차
### 1-1. Terraform으로 AWS 인프라 배포
``` bash
# terraform 디렉토리로 이동
cd xinfra/ec2-single

# terraform plan 확인
terraform plan

# 인프라 배포
terraform apply
```

### 1-2. RDS 생성 시 주의사항
- terraform RDS 생성 시 주의사항으로는 Github Action secret environment에 사전에 정의할 정보와 정확히 일치해야한다는 점이다.
- runner environment의 경우 runner 인스턴스의 localhost에 올라가는 MySQL DB를 사용하므로, DATABASE_URL End-Point를 localhost로 하드코딩 해도 문제 없음
1. MYSQL_USER
2. MYSQL_PASSWORD
3. MYSQL_ROOT_PASSWORD
4. DATABASE_URL(RDS End-Point로 정의)

### 1-3. S3 스토리지 End-Point 정의
- terraform apply 시 마지막에 출력되는 각 리소스들의 End-Point를 Ci/CD 프로젝트의 Action secret environment에 정의해야함
