# 웹 개요 및 웹 표준(Web Standards)

팀 버너스리 

### 웹 History

1. 알파넷 ARPANET 
2. 팀버너스리 WWW서비스 개발
3. 1993, 최초의 웹 브라우저 모자이크 개발, 넷스케이프 등장
4. 프로토콜로 네트워크 연결되어 있음. 

##### 웹 WWW(WEB이란?)

- 하이퍼텍스트, 하이퍼미디어를 기반으로 URL 주소체계를 사용하여 인터넷 대부분인 자원인 멀티미디어 정보를 검색할 수 있는 서비스 
- 정보자원들의 네트워크 

##### 웹의 3요소

* 규격화되고 통일된 웹자원의 위치지정 (URI)
* 웹의 자원이름에 접근하는 프로토콜 (HTTP)

##### [URL URI의 차이]

URL : 위치를 나타낸다. 

URI  (Universal Resource Identifier): 구체적인 위치를 나타낸다. (식별자 역할을 한다. )

	* 상대 URI : 상대 URL의 위치정보를 저장하지 않음 

#### 인터넷 속의 웹

* WEB1.0 : 브라우저를 통해 볼 수 있는 내용은 TEXT위주 , 단방향 통신

* Web.2.0 : 양뱡향통신

* Web3.0 : 서버가 필요 없는 클라우드
  * Saas(Software as a Service) : 소프트웨어에서 서비스웨어로의 변화

![1538116938399](C:\Users\KOSTA\AppData\Local\Temp\1538116938399.png)

# HTML소개 및 기본 구문

### HTML : Hyper Text Markup Language

* 웹에서 사용하는 파일은 *.html(*.htm)
  * 다른 이유 : 유닉스 때문이다. 
* 웹을 통해 전세계에 공유하고자 하는 웹문서 작성을 위한 마크업 언어
* 공유를 위해 Web Server 웹디렉토리에 저장되어, 웹 클라이언트에 다운로드 되어 파싱되고 렌더링되는 텍스트 언어이다. 
* HTML규격은 W3C에서 관리한다. 

![1538117307726](C:\Users\KOSTA\AppData\Local\Temp\1538117307726.png)

1] HTML을 서비스하는 웹 서버 다운받기 

 	아파치 - Tomcat 8.0 다운로드

	설치 : C:\KOSTA187\tools\apache-tomcat-8.0.53\bin

	startup.bat -> 서버 구동됨

* 문제 : 오라클 서버 8080과 충돌된다. 

* 해결 : conf -server.xml - editplus수정 (한글서비스 / 포트 80변경)

```
 <Connector port="80" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" URIEncoding="utf-8" />
    <!-- A "Connector" using the shared thread pool-->
```

* 재실행  startup.bat

* webapps : 웹 디렉토리의 위치 : default 위치 : ROOT

* 확인 : http://localhost/ => 아파치 톰캣 실행 

### 실습 준비하기

#### 1. 서버 설치했다! TomCat`

#### 2. FTP 프로그램 설치

기본 html 구문

```
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>난 혜림쓰</h1>
<p>여기는 문장 쓸 수 있따!!!!!!!!!!!!!!!!!!!!!</p>

</body>
</html>
```

* 기본 저장 파일 PATH : ROOT 아래, 



