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
> - [⚙️ 개발 결과물 사용 방법](#-개발-결과물-사용-방법)  
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

**Feel:lm**은 사용자의 감정과 일상을 기록하고 AI가 이를 분석하여 따뜻한 위로 메시지를 제공하는 감정 케어 모바일 앱입니다.

폴라로이드 필름 형태의 감성적인 UI와 AI 기반 감정 분석을 결합하여, 사용자가 쉽게 감정을 기록하고 스스로 치유할 수 있도록 돕습니다.

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
| ![일기 조회](https://github.com/user-attachments/assets/4b6f06fa-d7fe-4b5f-a9d8-c7b98b0b1b41) | ![일기 생성](https://github.com/user-attachments/assets/46f591dc-dc39-4e98-8111-d649815d2d55) | ![AI의 답장](https://github.com/user-attachments/assets/e1c6999f-4eaf-4b2a-be66-dead27a91553) |

&nbsp;

### 🔧 기술 스택

**Front-end**  
![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0A84FF?style=for-the-badge&logo=swift&logoColor=white)

**Back-end**  
![AWS Cloud](https://img.shields.io/badge/AWS%20Cloud-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

**Infra**  
![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=white)


&nbsp;

### 📊 시스템 아키텍처

![Image](https://github.com/user-attachments/assets/ef3c44a5-a63b-4ccc-8938-b3f25ec5b3ae)


- **클라우드 네이티브 구조로 설계되어**, 시스템은 자동으로 확장되며 상태를 저장하지 않는 방식으로 작동합니다. 인프라는 코드(Terraform)로 관리되어, 누구나 같은 환경을 쉽게 재현할 수 있습니다.  
- **AWS RDS는 인터넷에서 직접 접근할 수 없는 VPC 내부에 배치**되어 있어 외부 공격으로부터 안전합니다. 대신, 같은 네트워크 안에 있는 Lambda 함수만 접근할 수 있게 설정해 **데이터 보안 수준을 높였습니다.**  
- **서버리스 방식이기 때문에**, 사용자가 요청을 보낼 때만 컴퓨팅 자원이 작동합니다. 이 덕분에 **불필요한 리소스 낭비가 없고**, **운영 비용도 줄일 수 있습니다.**

&nbsp;

## ⚙️ 개발 결과물 사용 방법

### 🔧 설치 및 빌드 방법
1. 이 저장소를 클론합니다.
```bash
git clone https://github.com/your-repo-url/Feelim.git
```

2. Xcode에서 프로젝트를 엽니다.
```bash
open diary-for-f/Feelim-ios
```

3. 상단 Device에서 `iPhone 16 Pro (iOS 17.x)` 시뮬레이터 선택

4. `Cmd + R` 키 또는 Run 버튼을 클릭하여 빌드 및 실행

&nbsp;

### 🚀 실행 흐름 (시나리오)
1. 사용자가 일기 작성
2. AI 감정 분석
3. 제일 상단 줄에 추가된 일기 확인
4. 해당 일기 선택 후, 클릭해서 AI 답변 확인

&nbsp;

## 💡 활용 방안

- 🧠 **개인 감정 관리 및 자가치유**
- 🧑‍🏫 **교육 및 심리학 훈련 프로그램 활용**
- 🧑‍⚕️ **심리상담 보조 도구**
- 👩‍💼 **직장인·학생의 멘탈 케어**

&nbsp;
