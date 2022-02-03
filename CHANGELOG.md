# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

# 버전 예외사항 - 2020-11-24
현재 버전 번호는 semver규칙에 따라 처리하고 있으나, 잦은 기능 변경으로 주버전이
마구 올라갈 것으로 예상됨.
따라서 주버전은 현재 번호 1로 고정하고 부버전을 주버전 수버전을 부/수버전으로
임시 변경한다.

추후 패키지가 안정화되면, 현재 임시로 명한 flutter_jk도 변경하고
버전번호도 정상적으로 처리한다.


## Unreleased - 

## 1.11.2 - 2022-02-03
### Added
- 4대 보험 계산기 추가

## 1.11.1 - 2022-01-29
### Added
- PlatformInfo 추가

## 1.11.0 - 2022-01-04
### Removed
- get 패키치 참조 제거

### Changed
- GetXMessages -> Translations 로 변경

## 1.10.0 - 2021-10-15
### Removed
- permission_manager 제거, 소스 얼마 되지도 않는데 괜히 어기에 넣었다가 dependency 관리가 더 힘들어서 빼버림.

## 1.9.1 - 2021-06-26
### Fixed
- NumberButtonBar type casting 오류 수정

## 1.9.0 - 2021-06-19
### Changed
- null-safety 지원

## 1.8.1 - 2021-05-02
### Fixed
- IncomeTaxCalc 2021년 기준으로 계산되지 않는 현상 수정

## 1.8.0 - 2021-05-02
### Added
- IncomeTaxCalc 2021년 기준 추가

### Changed
- IncomeTaxCalc 사용방법 변경

## 1.7.0 - 2021-04-29
### Changed
- IncomeTaxCalc 기준년도 함수보다 별도로 인자로 받지 않도록 변경

## 1.6.1 - 2021-04-29
### Added
- income_tax_calc 속성 추가

## 1.6.0 - 2021-04-24
### Changed
- get: ^3.13.2 > get: ^4.1.4

## 1.5.5 - 2020-12-05
### Added
- SingleTouchDetector

## 1.5.4 - 2020-12-03
### Added
- 번역값 추가

## 1.5.3 - 2020-12-02
### Added
- 번역 일부 추가

## 1.5.2 - 2020-11-28
### Added
- 번역 일부 추가

## 1.5.1 - 2020-11-27
### Added
- add showOptionsDialog 

## 1.5.0 - 2020-11-24
### Changed
- NumberButtonBar 사용방식 변경

### Added
- NumPad widget 추가
- MoneyMaskedTextController 추가

## 1.4.1 - 2020-11-21
### Changed
- 외부 Package는 export 하지 않도록 수정

## 1.4.0 - 2020-11-18
### Added
- 번역 일부 추가
- KrUtils.numberToManwon 1000단위 comma 표시 기능 추가

## 1.3.0 - 2020-11-18
### Added
- Add PermissionManager.checkAndRequestStorate

### Changed
- PermissionManager 내부 구현 개선

## 1.2.0 - 2020-11-16
### Added
- Add NumberButtonBar widget

## 1.1.0 - 2020-11-15
### Added
- Add NumStepper widget

## 1.0.2 - 2020-11-15
### Added
- 소득세 도움말 추가

## 1.0.1 - 2020-11-06
### Fixed
- 기타소득세 계산시 원단위 절사

## 1.0.0 - 2020-11-05
### Chnaged
- IncomeTaxCalc 사용방식 변경
### Added
- IncomeTaxCalc 계산기준일 추가

## 0.1.2 - 2020-11-01
### Changed
- KrUtils.numberToManwon suffix 인자 추가

### Added
- 소득세계산(IncomeTaxCalc) 추가

## 0.1.1 - 2020-10-19
### Fixed
- poland locale 이름 수정

## 0.1.0 - 2020-10-18
### Added
- get package 추가
- localization messages 추가

## 0.0.3 - 2020-10-01
### Added
- KrUtils 추가

## 0.0.2 - 2020-09-05
### Added
- IconTextButton enabled 속성 추가
- PermissionManager 추가


## [0.0.1] - TODO: Add release date.

* TODO: Describe initial release.
