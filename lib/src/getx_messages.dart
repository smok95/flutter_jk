import 'package:get/get.dart';

class GetxMessages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => _messages;

  bool add(String locale, String msgId, String msg) {
    final key = _messages[locale];
    if (key == null) return false;

    key[msgId] = msg;
    return true;
  }

  Map<String, Map<String, String>> _messages = {
    'en_US': {
      'app info': 'About this app',
      'Are you sure you want to clear history?':
          'Are you sure you want to clear history?',
      'Are you sure you want to exit?': 'Are you sure you want to exit?',
      'average': 'AVG',
      'cancel': 'Cancel',
      'close': 'Close',
      'copy': 'Copy',
      'dark mode': 'Dark Mode',
      'decibel0 example': 'Threshold of hearing',
      'decibel10 example': 'Breathing',
      'decibel20 example': 'Leaves rustling',
      'decibel30 example': 'Whisper',
      'decibel40 example': 'Quiet library',
      'decibel50 example': 'Moderate rainfall',
      'decibel60 example': 'Normal conversation',
      'decibel70 example': 'Traffic, Vacuums',
      'decibel80 example': 'Alarm clocks',
      'decibel90 example': 'Hair dryers, Lawnmowers',
      'decibel100 example': 'Subway train',
      'decibel110 example': 'Car horns, Concerts',
      'decibel120 example': 'Jet planes(during take off)',
      'error': 'Error',
      'flashlight': 'Flashlight',
      'google url': 'www.google.com',
      'Information': 'Information',
      'installed date': 'Installed',
      'keep the device awake': 'Keep the device awake',
      'keep the screen on': 'Keep the screen on',
      'maximum': 'MAX',
      'minimum': 'MIN',
      'more apps': 'More apps',
      'off': 'Off',
      'ok': 'Ok',
      'on': 'On',
      'open': 'OPEN',
      'open settings': 'OPEN SETTINGS',
      'open website automatically': 'Open website automatically',
      'pause': 'Pause',
      'permission denied': 'Permission denied',
      'please allow permission':
          'Necessary permissions are denied. Please allow in Settings.',
      'Purchase History': 'Purchase History',
      'rate review': 'Rate 5 stars',
      'remove': 'Remove',
      'resume': 'Resume',
      'reset': 'Reset',
      'Scan History': 'Scan History',
      'scan result': 'Scan Result',
      'screenshot': 'Screenshot',
      'screenshot saved': 'Screenshot saved',
      'search': 'Search',
      'settings': 'Settings',
      'share': 'Share',
      'share app': 'Share App',
      'show example noise level': 'Show the example noise level',
      'updated date': 'Updated',
      'vibrate': 'Vibrate',
      'view code': 'View code',
    },
    'ko_KR': {
      'Are you sure you want to clear history?': '정말 모든 기록을 삭제하시겠습니까?',
      'Are you sure you want to exit?': '종료하시겠습니까?',
      'app info': '앱 정보',
      'average': '평균',
      'cancel': '취소',
      'close': '닫기',
      'copy': '복사',
      'dark mode': '야간 모드',
      'decibel0 example': '가청한계',
      'decibel10 example': '',
      'decibel20 example': '낙엽 스치는 소리',
      'decibel30 example': '속삭이는 소리',
      'decibel40 example': '조용한 도서관',
      'decibel50 example': '비내리는 소리, 조용한 대화',
      'decibel60 example': '일반적인 사무실 또는 대화소리',
      'decibel70 example': '전화벨, 시끄러운 사무실',
      'decibel80 example': '지하철의 차내소음, 피아노 소리',
      'decibel90 example': '고함소리, 소음이 심한 공장',
      'decibel100 example': '열차 통화시 철도변 소음, 공장내부',
      'decibel110 example': '자동차의 경적소음, 사이렌소리',
      'decibel120 example': '전투기의 이착륙소음, 폭죽소리',
      'error': '오류',
      'flashlight': '손전등',
      'google url': 'www.google.co.kr',
      'Information': '정보',
      'installed date': '설치 일자',
      'keep the device awake': '기기를 켜진 상태로 유지',
      'keep the screen on': '화면을 켜진 상태로 유지',
      'maximum': '최대',
      'minimum': '최소',
      'more apps': '다른 앱 보기',
      'off': '끔',
      'ok': '확인',
      'on': '켬',
      'open': '열기',
      'open settings': '설정 열기',
      'open website automatically': '웹사이트 자동으로 열기',
      'pause': '일시정지',
      'permission denied': '권한 없음',
      'please allow permission': '권한이 없어 해당 기능을 사용할 수 없습니다. 앱 설정에서 권한을 허용해주세요.',
      'Purchase History': '구매내역',
      'rate review': '별점주기',
      'remove': '삭제',
      'resume': '재시작',
      'reset': '초기화',
      'Scan History': '스캔 내역',
      'scan result': '스캔 결과',
      'screenshot': '화면캡쳐',
      'screenshot saved': '화면캡쳐 성공',
      'search': '검색',
      'settings': '설정',
      'share': '공유',
      'share app': '앱 공유하기',
      'show example noise level': '소음수준 비교정보 표시',
      'updated date': '업데이트 일자',
      'vibrate': '진동 알림',
      'view code': '코드 보기',
    },
    'pl_PL': {
      // Polish
      'Are you sure you want to clear history?':
          'Czy na pewno chcesz usunąć wszystkie przedmioty?',
      'Are you sure you want to exit?': 'Are you sure you want to exit?',
      'app info': 'Informacje o aplikacji',
      'average': 'AVG',
      'cancel': 'Anuluj',
      'close': 'zamknij',
      'copy': 'Kopiuj',
      'dark mode': 'tryb ciemny',
      'decibel0 example': 'teoretyczny próg słyszenia',
      'decibel10 example': 'szelest liści przy łagodnym wietrze',
      'decibel20 example': 'szept',
      'decibel30 example': 'bardzo spokojna ulica bez ruchu',
      'decibel40 example': 'szmery w domu',
      'decibel50 example': 'szum w biurach',
      'decibel60 example': 'odkurzacz, rozmowa',
      'decibel70 example': 'wnętrze głośnej restauracji, wnętrze auta',
      'decibel80 example': 'głośna muzyka w pomieszczeniach, trąbienie,',
      'decibel90 example': 'ruch uliczny',
      'decibel100 example': 'motocykl bez tłumika',
      'decibel110 example': 'piła łańcuchowa, tartaczna, krosno tkackie',
      'decibel120 example':
          'wirnik helikoptera w odległości 5 metrów, dyskoteka, młot pneumatyczny',
      'error': 'Błąd',
      'flashlight': 'Latarka',
      'google url': 'www.google.pl',
      'Information': 'Informacje',
      'installed date': 'Installed',
      'keep the device awake': 'Keep the device awake',
      'keep the screen on': 'Zachowaj ekran włączony',
      'maximum': 'MAX',
      'minimum': 'MIN',
      'more apps': 'Więcej aplikacji',
      'off': 'Off',
      'ok': 'Ok',
      'on': 'On',
      'open': 'Otwarte',
      'open settings': 'Otwórz ustawienia',
      'open website automatically': 'Open website automatically',
      'pause': 'Pauza',
      'permission denied': 'Brak uprawnień',
      'please allow permission':
          'Necessary permissions are denied. Please allow in Settings.',
      'Purchase History': 'Historia zakupów',
      'rate review': 'Rate 5 stars',
      'remove': 'Usuń',
      'resume': 'Resume',
      'reset': 'Resetuj',
      'Scan History': 'Scan Historia',
      'scan result': 'Scan Rezultat',
      'screenshot': 'Zrzut ekranu',
      'screenshot saved': 'Screenshot saved',
      'search': 'szukanie',
      'settings': 'Ustawienia',
      'share': 'Dzielić',
      'share app': 'Share App',
      'show example noise level': 'Show the example noise level',
      'updated date': 'Updated',
      'vibrate': 'Vibrate',
      'view code': 'View code',
    },
  };
}
