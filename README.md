# 📸 Feel:lm - 감정 기록 및 AI 위로 서비스
**감정을 기록하고 AI를 통해 프라이버시를 지키며 따뜻하게 위로 받는 폴라로이드 감성 모바일 앱**

&nbsp;

📚 목차

> - [📌 프로젝트 명](#-프로젝트-명)  
> - [👥 프로젝트 멤버 및 역할](#-프로젝트-멤버-및-역할)  
> - [🌈 프로젝트 소개](#-프로젝트-소개)  
> - [🚩 프로젝트 필요성](#-프로젝트-필요성)  
> - [🔎 관련 기술/논문/특허 조사](#-관련-기술논문특허-조사)
> - [🏗️ 결과물](#-결과물)
> - [📊 시스템 아키텍처](#-시스템-아키텍처)
> - [⚙️ 개발 결과물 사용 방법](#-개발-결과물-사용-방법)
> - [🚀 실행 흐름 (시나리오)](#-실행-흐름-시나리오)
> - [💡 활용 방안](#-활용-방안)

&nbsp;

## 📌 프로젝트 명

**Feel:lm - 감정 기록 및 AI 위로 서비스 모바일 애플리케이션**

&nbsp;

## 👥 프로젝트 멤버 및 역할

| 이름 | 담당 역할 |
|:----:|:---------|
| **박준우** | 클라우드 인프라 구축, Terraform 설정 |
| **김동인** | UI/UX 디자인, 프론트엔드(iOS) 개발 |
| **이준태** | 백엔드 개발, 데이터베이스 설계 |

&nbsp;

## 🌈 프로젝트 소개

**Feel:lm**은 사용자의 **감정과 일상을 기록하고 AI가 이를 분석하여 따뜻한 위로 메시지를 제공하는 감정 케어 모바일 앱**입니다.

**폴라로이드 필름 형태의 감성적인 UI와 AI 기반 감정 분석을 결합**하여, 사용자가 쉽게 감정을 기록하고 스스로 치유할 수 있도록 돕습니다.

&nbsp;

## 🚩 프로젝트 필요성

- **감정 표현의 어려움 해소**  ➔ 나만의 공간에서 솔직한 감정 기록 가능

- **AI 기반 정서적 지원**  ➔  상담 접근성이 낮은 사용자를 위한 AI 위로 제공

- **다양한 감정 활용 시나리오 제공**  ➔  일상 기록, 스트레스 해소, 행복 회상 등 다양한 목적에 활용

&nbsp;

## 🔎 관련 기술/논문/특허 조사

### 🔸 유사 서비스 비교

| 서비스 | 특징 | 차별점 |
|--------|------|--------|
| **답다** | 감정 선택 후 AI 친구가 12시간 내 답장 | 대화형 감정 케어 |
| **Replika** | AI 챗봇 기반 감정 지원 | 지속 대화 및 사용자 성향 학습 |

### 🔹 Feel:lm의 차별점
- 폴라로이드 UI로 감정 시각화  
- 감정 기록 → 실시간 AI 답장 생성 → 맞춤형 위로까지 통합 제공  
- 기록 중심의 정서 관리 앱
- 사용자의 개인정보 학습 X

&nbsp;

## 🏗️ 결과물

| 일기 조회 | 일기 생성 | AI의 답장 |
|:---------:|:---------:|:---------:|
| ![클컴_텀프_일기조회](https://github.com/user-attachments/assets/47e178eb-3bd3-48bf-b628-f670d64d001d) | ![클컴_텀프_일기작성](https://github.com/user-attachments/assets/4b82060e-fe9d-4a9a-a11b-510fd92342a2) | ![클컴_텀프_답장](https://github.com/user-attachments/assets/d80326f3-efc4-4e98-8752-49e1cee76737)|

&nbsp;

## 🔧 기술 스택

**Front-end**  
![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0A84FF?style=for-the-badge&logo=swift&logoColor=white)

**Back-end**  
![AWS Cloud](https://img.shields.io/badge/AWS%20Cloud-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

**Infra**  
![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=white)


&nbsp;

## 📊 시스템 아키텍처

![Image](https://github.com/user-attachments/assets/ef3c44a5-a63b-4ccc-8938-b3f25ec5b3ae)

Feel:lm의 서버는 **클라우드 네이티브 아키텍처**로 설계되었습니다. 시스템은 자동으로 확장될 수 있고 상태를 저장하지 않는 방식으로 작동하도록 하였습니다. 모든 인프라는 **Terraform**을 통해 Infrastructure as Code(IaC) 방식으로 관리되어 일관성 있고 재현 가능한 배포 환경을 제공합니다.
   
위 시스템 아키텍처는 총 **4개의 계층**과 **외부 서비스**로 나눌 수 있으며, 각각은 아래와 같은 특징을 가집니다.

### 1. 네트워크 계층 (VPC)
**AWS VPC(Virtual Private Cloud)** 를 기반으로 한 안전하고 격리된 네트워크 환경을 구축했습니다.
외부로의 접근을 차단해야 하는 리소스와 외부와의 통신이 필요한 리소스를 각각 분리된 서브넷에 배치하였습니다. Subnet은 **Private Subnet**과 **Private Subnet**으로 나누었고 각각은 다음과 같은 특징을 가집니다.
- **Private Subnet**
  - RDS 데이터베이스 배치
  - 외부 직접 접근 차단으로 보안성 강화
  - 내부 리소스 간 통신만 허용
- **Public Subnet**
  - Lambda 함수 배치
  - Internet Gateway를 통한 외부 통신 가능
  - API 요청 처리 및 외부 서비스 연동

 Private Subnet과 Public Subnet간의 통신이 필요한 경우 (예: Lambda함수가 데이터베이스에 접근), `Security Group`을 통해 인증하도록 하여 보안을 강화하였습니다.
    
 Public Subnet과 외부 서비스와의 통신이 필요한 경우 (예: Lambda함수가 AWS Bedrock에 요청), `VPC Endpoint`를 구성하여 불필요한 외부 접근을 최소화하였습니다.

### 2. 데이터 계층
사용자의 데이터와 AI모델의 응답이 저장되는 곳입니다. 저희는 **Amazon RDS(MySQL 8.0)** 을 사용하여 데이터를 저장하였습니다. 관계형 데이터베이스를 활용하여 감정(예: 슬픔, 기쁨 등)과 일기 엔티티에 대한 **1:N 관계를 효율적으로 정의**하였습니다.
- 배치 위치: Private Subnet
- 보안 구성: Security Group을 통해 Lambda 함수에서만 접근 허용
- 보안 강화: 네트워크 레벨에서 데이터베이스 직접 접근 차단

### 3. 애플리케이션 계층
**AWS Lambda**를 사용하여 대부분의 비즈니스 로직을 처리하도록 하였습니다. Lambda는 서버리스 컴퓨팅 리소스로, 사용자의 요청이 있을 때만 작동됩니다. 따라서 **불필요한 리소스 낭비가 없고, 운영 비용을 효율적으로 줄일 수 있습니다.**
- 배치 위치: Public Subnet
- 주요 특징:
  - 서버리스 컴퓨팅으로 인프라 관리 부담 최소화
  - 자동 스케일링으로 트래픽 변화에 유연한 대응
  - RDS와 Bedrock 서비스 간 중계 역할 수행

### 4. API 계층
**AWS API Gateway**를 사용해 REST API를 구성하고 클라이언트 요청을 애플리케이션 계층으로 전달해주는 역할을 합니다.
   
또한, API Gateway는 외부로서의 진입점으로, **AWS PROXY**를 사용하여 외부로부터 내부 애플리케이션 계층(Lambda함수들)을 숨기는 역할도 하도록 구성하였습니다.
- 주요 기능:
  - 클라이언트 요청의 진입점 역할
  - API 버전 관리
  - 인증 및 권한 관리
  - 모니터링 및 로깅
 
### 5. AI 서비스 연동
**Amazon Bedrock**의 **Claude Sonnet 3.5**를 사용하여 AI는 일기 속 단어와 문장의 맥락을 이해하고, 여섯 가지 고정 감정인 **Joy(기쁨), Sadness(슬픔), Anger(분노), Fear(두려움), Surprise(놀람), Neutral(평온)** 중 가장 뚜렷하게 드러나는 감정을 판단합니다.
   
그리고 사용자가 입력한 감정과 AI가 예측한 감정을 비교 분석하여, **감정 일치도**와 함께 적절한 **위로 메시지**를 제공합니다.
이를 통해 사용자는 자신의 감정을 더 깊이 이해하고, AI로부터 따듯한 위로 메시지를 제공 받습니다.

- 기능: 텍스트 요약 AI 모델 제공
- 연결 방식: VPC Endpoint를 통한 안전한 통신
- 데이터 전송: AWS 내부 네트워크를 통한 효율적인 처리

&nbsp;

## ⚙️ 개발 결과물 사용 방법

### Prerequisite
1. 이 저장소를 클론합니다.
```bash
git clone https://github.com/diary-for-F/diary-for-f.git
```

2. Terraform CLI, AWS CLI가 설치되어 있어야 합니다.
- Terraform이 없는 경우: [이 링크](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)를 참고하여 설치합니다.
- AWS CLI가 없는 경우: [이 링크](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)를 참고하여 설치합니다.

3. AWS CLI를 통해 AWS 프로젝트와 연결합니다.
  1. AWS 콘솔 > IAM > Users 에 접속해서 개인 계정을 클릭하여 Access Key를 생성합니다.
  2. 터미널에서 aws configure --profile diary-for-f를 실행하여 저장해두었던 Access Key와 Secret을 입력합니다.

### 클라이언트 설치 및 빌드 방법

2. Xcode에서 프로젝트를 엽니다.
```bash
open diary-for-f/Feelim-ios
```

3. 상단 Device에서 `iPhone 16 Pro (iOS 17.x)` 시뮬레이터 선택

4. `Cmd + R` 키 또는 Run 버튼을 클릭하여 빌드 및 실행

### 서버 설치 및 빌드 방법
1. `terraform/` 디렉토리에서 Terraform을 셋업합니다.
```bash
terraform init
```

2. Terraform Plan을 만들어 생성될 리소스를 확인합니다.
```bash
terraform plan -out=plan.plan
```

3. Terraform Apply로 리소스를 생성합니다.
```bash
terraform apply plan.plan
```

&nbsp;

## 🚀 실행 흐름 (시나리오)
### 기본 사용 흐름
1. **일기 작성**: 사용자가 하루의 감정과 경험을 자유롭게 작성하고, 최대 3가지의 감정 태그를 선택
2. **AI 감정 분석**: Amazon Bedrock AI가 일기 내용을 분석하여 가장 강하게 느껴지는 감정을 도출하고 맞춤형 위로 메시지 생성
3. **폴라로이드 필름 추가**: 작성된 일기가 홈 화면 상단에 폴라로이드 필름 형태로 추가되어 시각적으로 표시
4. **위로 메시지 확인**: 해당 필름을 탭하면 뒤집어지면서 AI가 생성한 따뜻한 위로 메시지와 감정 분석 결과 확인

### 상세 사용 시나리오
- **직장인 스트레스 관리**: 퇴근 후 업무 스트레스와 피로감을 기록하고, AI의 공감과 격려 메시지를 통해 정서적 안정 획득
- **대학생 시험 기간**: 학업 압박과 불안감을 털어놓고, AI의 응원과 동기부여 메시지로 심리적 지원 받기
- **일상의 행복한 순간**: 소중한 추억과 긍정적 감정을 기록하여 나중에 다시 읽으며 행복감 재경험
- **감정 변화 추적**: 시간의 흐름에 따른 감정 패턴을 폴라로이드 필름들을 통해 시각적으로 확인

&nbsp;

## 💡 활용 방안
- **개인 감정 관리 및 자가치유**: 일상적인 감정 기록을 통해 자신의 감정 패턴을 이해하고, AI의 맞춤형 위로 메시지를 통해 정서적 안정을 도모할 수 있습니다. 특히 감정 표현이 어려운 현대인들에게 안전한 감정 출구를 제공합니다.
- **교육 및 심리학 훈련 프로그램 활용**: 심리학과 학생들의 감정 인식 훈련이나 상담 심리학 실습에 활용 가능하며, 감정 분석 AI의 결과를 통해 감정 이해도를 높일 수 있습니다.
- **심리상담 보조 도구**: 전문 상담사가 내담자의 일상 감정 패턴을 파악하는 보조 도구로 활용할 수 있으며, 상담 세션 간격 사이의 감정 변화를 추적하는 데 도움이 됩니다.
- **직장인·학생의 멘탈 케어**: 업무나 학업 스트레스로 인한 번아웃 예방을 위해 정기적인 감정 체크와 AI 기반 정서적 지원을 받을 수 있으며, 24시간 언제든지 접근 가능한 멘탈 케어 서비스를 제공합니다.

&nbsp;
