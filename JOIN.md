# JOIN

- 두개 이상의 테이블로부터 다양한 방법으로 조건을 만족하는 테이블 데이터 

- Primary Key , Foreign Key 

![1537230989850](C:\Users\KOSTA\AppData\Local\Temp\1537230989850.png)

			[자식테이블]   ---------------------------------  [ 부모테이블] 

공통점] 1) 부서번호가 일치해야 한다. 

## JOIN의 종류

![1537231073007](C:\Users\KOSTA\AppData\Local\Temp\1537231073007.png)

### 1_ CROSS JOIN

* 조인 조건 없이 한개 이상의 테이블에 대한 조인을 말한다. 

* (이론상의 조인) -> 실제로는 사용되지 않는다. (실무상 사용X)
* 모든 가능한 조합이 검색되어 많은 결과 출력 가능

![1537231210813](C:\Users\KOSTA\AppData\Local\Temp\1537231210813.png)

2) 별칭 사용으로 모호성 해결 가능

	employees e / departments d 

```
SELECT first_name, department_name
from employees, departments;

-- 크로스 조인
select e.first_name, d.DEPARTMENT_NAME
from employees e, departments d;

--DBMS간 호환을 위해 ANSI에서 제시한 CROSS JOIN 구문
-- 아래처럼 사용하는 것이 좋다. 
select e.EMPLOYEE_ID, e.last_name, d.DEPARTMENT_NAME
from employees e 
      CROSS JOIN departments d;
```

## INNER JOIN 내부 조인

- Natural Join : 가장 자연스러운 조인 

* 부모와 자식의 관계를 가진 2개 이상의 테이블에서 공통되는 칼럼 비교하여 조건 만족하는 행과 행의 조인  / 테이블간의 교집합을 조인 
* EQUI JOIN

##### A  JOIN B ON 조건 

##### 1]EQUI 조인

![1537233569825](C:\Users\KOSTA\AppData\Local\Temp\1537233569825.png)

![1537232866298](C:\Users\KOSTA\AppData\Local\Temp\1537232866298.png)

 - ANSI 표준 조인 사용을 권장함 :-)

```
-- ANSI표준 EQUI JOIN구문
select e.employee_id,
        e.last_name,
        d.department_name
from employees e 
      join departments d 
      on e.department_id = d.department_id
where e.salary >= 3000;
```



#### NON-EQUI JOIN

* 연결하는 테이블 내용값이 범위에 소속되는 경우 사용하는 조인 

![1537234046948](C:\Users\KOSTA\AppData\Local\Temp\1537234046948.png)

![1537234054664](C:\Users\KOSTA\AppData\Local\Temp\1537234054664.png)

#### 예제] 연봉 범위를 확인해 내 연봉으로 직무 확인

```
--NON-EQUI JOIN
select e.employee_id, e.last_name, e.salary, j.JOB_TITLE
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
order by e.employee_id;
```

- 범위를 토대로 조인을 실행한다.
- 결과값이 2개 나올 수 있다. king (Administra & President)

## OUTER JOIN

* INNER 조인 시, 조인 조건을 만족하지 않는 행은 검색되지 않는다.
* 조인 조건을 만족하지 않는 행들도 검색에 포함하기 위해 사용한다. 
* 부서번호가 NULL인 경우 

##### 실습] 

![1537234725483](C:\Users\KOSTA\AppData\Local\Temp\1537234725483.png)

![1537234733872](C:\Users\KOSTA\AppData\Local\Temp\1537234733872.png)

```
-- OUTER JOIN
SELECT employee_id, department_name
          FROM employees e, departments d
          WHERE e.department_id = d.department_id (106 row)
                         (같은값을 갖는것만 검색된다.)
                         
-- 값을 모두 갖고 있는 쪽에 (+)
SELECT e.employee_id, e.first_name, e.last_name, d.department_name
FROM employees e, departments d
where e.department_id = d.department_id(+);
- 107개의 결과값 확인 가능하다. 

---LEFT, RIGHT로 붙여준다----
--OUTER JOIN ANSI 표준 [LEFT] 이렇게 사용하는것이 정석 
-- ANSI 표준 OUTER JOIN(LEFT, RIGHT, FULL 예약어 사용)
--  LEFT OUTER JOIN : 오른쪽 값이 NULL인 경우 
-- 이름과 부서명 인출시 , 부서명 null값도 붙여주기 
SELECT e.first_name, 
          d.department_name 
FROM   employees e 
          LEFT OUTER JOIN departments d 
             ON e.department_id = d.department_id; 

-- RIGHT OUTER JOIN
-- 왼쪽 값이 NULL 인 경우 인출 
-- 이름과 부서명 인출 시, 이름 null값 붙여주기 
SELECT e.first_name, 
          d.department_name 
FROM   employees e 
          RIGHT OUTER JOIN departments d 
             ON e.department_id = d.department_id; 

-- FULL OUTER JOIN
-- 양쪽 모두 NULL인 경우 인출 
SELECT e.first_name, 
          d.department_name 
FROM   employees e 
          FULL OUTER JOIN departments d 
             ON e.department_id = d.department_id; ; 

```

## SELF JOIN

* 같은 테이블에 별칭을 부여하여 다른 테이블처럼 조인하는 것
* 하나의 테이블로 스스로 조인하기 / 자신의 테이블의 참조 
* 상사별 상사 이름 검색시, SELF JOIN 필요

![1537235287506](C:\Users\KOSTA\AppData\Local\Temp\1537235287506.png)

```
--SELF JOIN!!!!!!!!!! : Employees 1.employee / 2. manager
-- 사원별 상사 검색 / 내이름 + 상사이름 
SELECT employee.first_name , manager.first_name
FROM EMPLOYEES employee, EMPLOYEES manager
WHERE employee.manager_id = manager.employee_id;

-- 상사가 없는 사원도 검색 시 OUTER JOIN 필요
-- 내이름 + 상사이름 / 내이름 + NULL
SELECT employee.first_name , manager.first_name
FROM EMPLOYEES employee, EMPLOYEES manager
WHERE employee.manager_id = manager.employee_id(+);

-- 오라클 조인 [훨씬 명확하다] ->위에랑 같은 값 오른쪽 null
SELECT employee.first_name , manager.first_name
FROM EMPLOYEES employee LEFT OUTER JOIN EMPLOYEES manager
ON employee.manager_id = manager.employee_id;
```

```
이름 존재하는 직속 상사의 정보 출력
SELECT A.last_name, B.last_name
FROM employees A, employees B
WHERE A.manager_id = B.employee_id
		AND A.last_name = 'kochhar'
```

#### 예제문제

```
1. 이름이 ‘Himuro’인 사원의 부서명을 출력하라.
SELECT e.last_name, d.department_name
          FROM employees e , departments d
          WHERE e.department_id = d.department_id
          AND e.last_name ='Himuro'

2. 직종명이 'Accountant'인 사원의 이름과 부서명을 출력하라.
SELECT e.last_name, d.department_name
          FROM employees e , departments d , jobs j
          WHERE e.department_id = d.department_id
          AND e.job_id = j.job_id
          AND j.job_title ='Accountant'

>ANSI
SELECT e.last_name, d.department_name
          FROM employees e 
          JOIN departments d
          ON e.department_id = d.department_id
          JOIN jobs j
          ON e.job_id = j.job_id
          WHERE j.job_title ='Accountant'

3. 커미션을 받는 사람의 이름과 그가 속한 부서를 출력하라.
SELECT e.last_name, d.department_name
          FROM employees e , departments d 
          WHERE e.department_id = d.department_id
          AND Commission_pct IS NOT NULL

>ANSI
SELECT e.last_name, d.department_name
          FROM employees e , departments d 
          WHERE e.department_id = d.department_id
          AND Commission_pct IS NOT NULL

4. 지역명 'Seattle'에 근무하는 사원의 이름, 급여, 부서명을
   출력하라.
SELECT e.last_name, e.salary, d.department_name
          FROM employees e , departments d , locations l
          WHERE e.department_id = d.department_id
          AND d.location_id = l.location_id
          AND l.city = 'Seattle'

5. 급여가 4000이하인 사원의 이름, 급여, 근무지를 출력하라.
SELECT e.last_name, e.salary, l.city
          FROM employees e , departments d , locations l
          WHERE e.department_id = d.department_id
          AND d.location_id = l.location_id
          AND e.salary <= 4000


6. 'Chen'과 동일한 부서에서 근무하는 사원의 이름을 출력하라.
SELECT A.last_name, B.last_name , B.department_id
          FROM employees A , employees B
          WHERE A.department_id= B.department_id
          AND A.last_name ='Chen'

```



# 서브쿼리

- 서브쿼리에서의 실행결과를 메인 쿼리에 전달하여 새로운 결과 검색
- 동적인 값을 갖고 JOIN

![1537237045726](C:\Users\KOSTA\AppData\Local\Temp\1537237045726.png)

두 번 작성해야 할 서브쿼리를 -> 한번에 작성하기 

괄호를 씌워주었기 때문에 괄호 안이 먼저 시행될 수 있다. 

![1537237162154](C:\Users\KOSTA\AppData\Local\Temp\1537237162154.png)

### 서브쿼리만 실행하고 싶을땐, F5키 누르기!

### 1) 예제, 단일행 서브쿼리 

	- 문제 : 전체 사원의 평균급여보다 더 많은 급여 받는 사원 찾기

![1537237640961](C:\Users\KOSTA\AppData\Local\Temp\1537237640961.png)

### 2) 예제, 다중행 서브쿼리 연산!_ 어렵쓰! 

![1537237657494](C:\Users\KOSTA\AppData\Local\Temp\1537237657494.png)

##### 1] IN, 30번 부서의 소속된 사원의 업무명과 동일한 모든 사원  (같은직무)

  - 여러개 값이기 때문에, IN을 사용한다. (동적인 값 확인 가능)
  - 30번 부서의 사원의 업무와 동일한 업무를 하는 모든 사원 목록 조회

##### 2] ANY, 30번 부서의 봉급보다 하나이상을 만족 (최소값)

  - 여러개의 값 중에서 최소값보다 더 작은 것 
  - 30번 부서의 최소급여자보다 더 많은 급여를 받는 전체 사원 목록 조회

```
*컬럼 > ANY (서브쿼리) == 컬럼 > MIN
 (가장 작은값 보다 큰값을 찾겠다.)
*컬럼 < ANY (서브쿼리) == 컬럼 < MAX
 (가장 큰값 보다 작은값을 찾겠다.)
```

##### 3] ALL, 여러개의 값 중에 모두를 만족하는 값 (최대값)

  - 30번 부서의 최대급여자보다 많은 급여 받는 목록 (SALARY >ALL)
  - salary >ALL :  / salary < ALL

```
*컬럼 > ALL (서브쿼리) ==  컬럼 > MAX
 (가장 큰값 보다 큰값을 찾겠다.)
*컬럼 < ALL (서브쿼리) ==  컬럼 < MIN
 (가장 작은 값 보다 작은값을 찾겠다.)
```

```
Q) 10번 부서에 가장작은 급여자 보다 작게 받는 급여자의 내역을 출력하라.

select * from emp
where sal< (select min(sal) from emp where dno = 10)
and dno!= 10

select * from emp
where sal < ALL (select sal from emp where dno = 10 )

Q.) (hr) 부서번호 30번 최대급여자 보다 급여가 높은 사원의 정보를 출력하라.
select * from employees
where salary > ALL (select salary from employees where department_id = 30)

Q.) (hr) 부서번호 30번 최대급여자 보다 급여가 적은 사원의 정보를 출력하라.
select * from employees
where salary < ANY (select salary from employees where department_id = 30)
```



##### 4] EXIST, 결과를 만족하는 값이 존재하는지 확인 (존재여부)

* 서브쿼리의 결과 유무에 따른 조회 

* 회사의 재고에 하나라도 있는 경우 실행(존재여부)

### 3) 다중 컬럼 서브쿼리

![1537237751604](C:\Users\KOSTA\AppData\Local\Temp\1537237751604.png)department _id, 두가지를 모두 비교하는 값 

* 부서별 최대 급여자 정보

```
Q ) 직무 (job_id) 별 최대 급여자의 사원내역을 출력하라.
SELECT max(salary) FROM employees
               GROUP BY job_id

SELECT employee_id, last_name, salary, job_id
           FROM employees
           WHERE salary = (SELECT max(salary) 
                                   FROM employees
                                   GROUP BY job_id)
```

* 20번 부서원들과 보너스가 같은 사원 검색

```
Q ) 20번 부서원들과 보너스가 같은 사원을 검색하라.
SELECT comm FROM emp
    
SELECT * FROM emp 
          WHERE comm IN( SELECT comm FROM emp
                                       WHERE dno = '20')
          AND dno!='20';
```



#### 예제 문제

```

SELECT AVG(salary) FROM employees;
Q)사원의 평균급여보다 큰 급여 + 이름 
SELECT last_name, salary
          FROM employees
          WHERE salary > (SELECT AVG(salary) FROM employees)


Q)'Chen' 보다 salary를 많이 받는 사원의 목록을 출력하라
SELECT last_name, salary
          FROM employees
          WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Chen')


Q) '정의찬' 과 부서가 다르고 동일한 업무를 하는 사원의 정보를 출력하라.
SELECT eno,ename,dno,job
          FROM emp
          WHERE dno != (SELECT dno FROM emp WHERE ename  = '정의찬' )
          AND job = (SELECT job FROM emp WHERE ename  = '정의찬')

Q) 부서 중 가장 급여를 많이 받는 부서를 검색하라.
SELECT max(avg(sal)) FROM emp
          GROUP BY dno

SELECT dno FROM emp 
          GROUP BY dno
          HAVING avg(sal) = (SELECT max(avg(sal)) 
FROM emp
GROUP BY dno)

1. 문제) ‘Patel’가 속해있는 부서의 모든 사람의 사원번호, 이름, 입사
         일, 급여를 출력하라.
select employee_id,last_name,hire_date,salary
          from employees
          where department_id = (select department_id 
from employees 
where last_name ='Patel')
          

2. 문제) ‘Austin'의 직무(job)와 같은 사람의 이름, 부서명, 급여, 직무를
          출력하라.
select e.last_name, d.department_name, e.salary , j.job_title , j.job_id
          from employees e, departments d, jobs j
          where job_id = (select j.job_id 
                                   from employees
                                   where last_name ='Austin')
          and d.department_id = e.department_id



select *
          from employees
          where job_id = (select job_id
                                   from employees
                                   where last_name ='Austin')


3. 문제) 10번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명,
          지역, 급여를 급여가 많은 순으로 출력하라.

SELECT * FROM emp 
          WHERE comm IN( SELECT comm FROM emp
                                       WHERE dno = '20')
          AND dno!='20';

select * from employees
          where 

select department_id from employees
          where department_id = 10


   
4. 문제) 'Seo'의 급여와 같은 사원의 사원번호, 이름,
           급여를 출력하라.
select employee_id,last_name, salary
          from employees
          where salary = (select salary 
                                   from employees
                                   where last_name ='Seo')


  
5. 문제) 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호,
          이름, 급여를 출력하라.
select employee_id,last_name, salary
from employees
where salary > (select max(salary) 
 from employees 
 where department_id = 30)
   

6. 문제) 급여가 30번 부서의 최저 급여보다 높은 사원의 사원번호,
          이름, 급여를 출력하라.
select employee_id,last_name, salary
from employees
where salary < (select min(salary) 
 from employees 
 where department_id = 30)


7. 문제) 전체 사원의 평균 임금보다 많은 사원의 사원번호, 이름,
         부서명, 입사일, 지역(city), 급여를 출력하라.
select e.employee_id ,e.last_name, d.department_name, e.hire_date, l.city
          from employees e , departments d, locations l
          where e.department_id = d.department_id
          and d.location_id = l.location_id
          and e.salary > (select avg(salary) from employees)


8. 문제) 30번 부서 사람들 중에서 20번 부서의 사원과 같은 업무를 하는
         사원의 사원번호, 이름, 부서명, 입사일, 지역(city)을 출력하라.
select e.employee_id ,e.last_name, d.department_name, e.hire_date, l.city
          from employees e , departments d, locations l
          where e.department_id = d.department_id
          and d.location_id = l.location_id
          and e.job_id IN (select job_id from employees where department_id = 20)
          and e.department_id = 30


9. 문제) 100번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의
         사원번호, 이름, 부서명, 입사일, 지역을 출력하라.
select e.employee_id ,e.last_name, d.department_name, e.hire_date, l.city
          from employees e , departments d, locations l
          where e.department_id = d.department_id
          and d.location_id = l.location_id
          and e.job_id IN (select job_id from employees where department_id <> 30)
          and e.department_id = 100
          
```



### 4) 서브쿼리와 가상 컬럼(슈도)의 활용 (응용예제)

* ROMID, ROWNUM
* ROMNUM : SELECT문에서 실행되는 과정에서 인출된 후 순차적으로 부여되는 동적 일련번호 
* 실행시마다 동적 생성되므로, 서로다른 값을 가진다. 

![1537238934435](C:\Users\KOSTA\AppData\Local\Temp\1537238934435.png)

![1537238940971](C:\Users\KOSTA\AppData\Local\Temp\1537238940971.png)

orderby만 주어도 -> rownum 이 떨어지지만 구현되면서 또 달라지는

=> rownum은 고정적이지 않다! 

```
SELECT * 
from employees
where ROWNUM >1;
```

=> 아무런 값도 반환되지 않는다. 

![1537239139287](C:\Users\KOSTA\AppData\Local\Temp\1537239139287.png)

```
--특정 컬럼을 기준으로 정렬하여 상위 5개의 범위 조회
--전체 급여 순이 아니라 처음 5명 내에서의 급여 순위 확인
Select first_name, salary
from employees
order by salary desc;

--전체에 대해 5명이 인출된다. WHY? orderby가 맨 마지막!
Select first_name, salary
from employees
where ROWNUM<=5
order by salary desc;
```

- 전체 급여 순  LIST 에서 5명 선발 (FROM절에서 서브쿼리사용=인라인뷰)

```
-- 전체 급여 순위 리스트 
SELECT *  
      FROM employees
      ORDER BY salary desc;
      
-- 급여 순위 중 상위 5명 찾기 
SELECT *
FROM (SELECT *  
      FROM employees
      ORDER BY salary desc)
where ROWNUM <= 5;
```

=> FROM절 안에서, 서브쿼리 사용 Inline view 

=> 예외 ) 10등부터 15등은 인출할 수 없다. 해결] 서브쿼리 다시 사용해서 응용

* ##### 급여 순으로 10~20등 사이 값 인출

![1537239734397](C:\Users\KOSTA\AppData\Local\Temp\1537239734397.png)

```
-- 급여순으로 10등 ~20등 값 인출
-- 1) 먼저 줄세우기
-- 2) 내용 값 서브쿼리 날리기
-- 급여순으로 10 ~ 20 사이 / 20~30 사이 : page 3 
SELECT page, 
          employee_id, 
          first_name, 
          salary 
FROM   (SELECT CEIL(ROWNUM / 10) page, 
                     employee_id, 
                     first_name, 
                     salary 
           FROM   (SELECT ROWNUM, 
                                employee_id, 
                                first_name, 
                                salary 
                      FROM   employees 
                      ORDER  BY salary DESC)) 
WHERE  page = 2; 

-- 1) 줄세우기 
SELECT ROWNUM,employee_id, first_name,salary 
FROM   employees 
ORDER  BY salary DESC;

-- 2) 서브쿼리 다시 
SELECT CEIL(ROWNUM / 10) page,   employee_id,  first_name,  salary 
 FROM   (SELECT ROWNUM, 
          employee_id, 
         first_name, 
        salary 
 FROM   employees 
ORDER  BY salary DESC);

```



##### 5등부터 15등 자르기

```
-- 5부터 15등까지 자르기 
-- 서브쿼리 다시 
SELECT CEIL(ROWNUM / 5) page,   employee_id,  first_name,  salary 
 FROM   (SELECT ROWNUM, 
          employee_id, 
         first_name, 
        salary 
        
 FROM   employees 
ORDER  BY salary DESC);

-- 인출
 SELECT page, 
          employee_id, 
          first_name, 
          salary 
FROM (SELECT CEIL(ROWNUM / 5) page,   employee_id,  first_name,  salary 
 FROM   (SELECT ROWNUM, 
          employee_id, 
         first_name, 
        salary 
        
 FROM   employees 
ORDER  BY salary DESC))
WHERE page = 2 or page = 3;
```

# 07. DML / TCL

## [DML 데이터 조작어 ]

### 1_ INSERT

![1537254088091](C:\Users\KOSTA\AppData\Local\Temp\1537254088091.png)

![1537255600990](C:\Users\KOSTA\AppData\Local\Temp\1537255600990.png)

			[ 서브쿼리 ] -> 복사해서 사용할 때 

#### 예제] 테스트를 위한 테이블 생성 (서브쿼리의 이용)

```
SQL> CREATE TABLE dept2
     AS SELECT * 
        FROM departments
        WHERE 0 = 1;
```

#####  => 데이터 구조만 복사해온 것 

```
insert into dept
select * 
from departments;
```

##### => 행 복사

```
select * 
from dept;
```

##### => 최종 확인 : 29개의 행 추가 완료

2_ 데이터 무결성 제약조건

* 테이블의 컬럼에 유효하지 않은 값이 입력되는 것 방지하기 위한 규칙

|   제약조건    | 표기 | 설명                                                         |
| :-----------: | ---- | ------------------------------------------------------------ |
|   NOT NULL    | NN   | NULL   값을   허용하지 않는다.                               |
|    UNIQUE     | UK   | 중복된   값을 허용하지 않는다(NULL   허용).                  |
| PRIMARY   KEY | PK   | UNIQUE와   NOT NULL의   조건을 만족하는 값을 허용한다.       |
| FOREIGN   KEY | FK   | 참조하는   부모테이블의 컬럼의   값이 존재하면 값을 허용한다. |
|     CHECK     | CK   | 제약조건을   설정할 때 설정한 값만을 허용한다.               |

* UNIQUE : 중복된 값을 허용하지 않는 경우 (NULL 허용)
* PRIMARY KEY : UNIQUE + NOT NULL조건 만족 
* FOREIGN KEY : 참조하는 부모테이블의 컬럼 값 존재-> NULL허용
* CHECK : 상수, 제약조건 설정시 사용 (남/여)  , (참/거짓)

![1537254422708](C:\Users\KOSTA\AppData\Local\Temp\1537254422708.png)

```
--1) INSERT KEY
INSERT INTO departments
              (department_id, --PK
              department_name,
              manager_id,   --FK : 명시적 NULL입력 
              location_id)  --FK : 명시적 NULL입력 
values (900, 'KOSTA', NULL, NULL);

--1) 키입력값 확인
select *
from departments;

--> 900을 넣는 이유? 
일렬번호 개념으로 작성 : 시퀀스 , 상수처리 
```

```
--2) 시퀀스를 이용한 부서번호 입력 
INSERT INTO departments( department_id, departmet_name, manager_id, location_id)
values (departments_seq.NEXTVAL, 'KOSTA', NULL, NULL);
--상수이름 : NEXTVAL / CURRENTVAL

-- HR 안에는 3개의 시퀀스가 존재한다. 
SELECT *
FROM user_sequences;

-- 주로 PK의 일련번호로 사용하기위해 사용된다. 
-- MIN - MAX 시작점 - 끝점 / Increment_by 증가단위
1) Department_seq
2) Employees_seq
3) Locations_seq
```

* 데이터 딕셔너리 : 제약조건이 무엇이 만들어졌는지 알 수 있는 것
* user_constraints :  자동으로 등록된 제약조건 확인 가능 

```
##### 데이터 딕셔너리 조회 ######
select * 
from user_constraints;

SELECT *
FROM user_sequences;

--전체 테이블 목록 확인 
SELECT *
FROM user_tables;
```

HR	DEPT_NAME_NN	C	DEPARTMENTS
HR	DEPT_ID_PK	P	DEPARTMENTS
HR	DEPT_LOC_FK	R	DEPARTMENTS

=> 반드시 입력 전에 내용 조회해보고, 그 내용에 맞게 INSERT해줘야한다!!

### UPDATE

![1537255925190](C:\Users\KOSTA\AppData\Local\Temp\1537255925190.png)

* 특정 행만 업데이트 해야 하기 때문에 WHERE안에 조건 걸어준다. 

* ##### 예제] Salary 전체 값에 10% 증가값으로 자료 인출하기  [행업데이트]

```
update employees
set salary = salary * 1.1
where department_id = 30;
```

### DELETE

![1537256095359](C:\Users\KOSTA\AppData\Local\Temp\1537256095359.png)

* ##### 예제] 이전에 작성한 KOSTA내용 삭제하기

```
delete from departments
where department_name LIKE '%KOSTA%';
```

* ##### 예제] 복사해놓은 EMP 테이블 삭제하기

## [TCL 트렌젝션 관리 언어]

* 데이터베이스에서의 TRANSACTION? 

  * 데이터를 처리하는 하나의 논리적 작업 단위 
  * 일련의 물리적 DML묶음으로 트렌젝션 종료 
  * COMMIT & ROLLBACK 명령어 실행을 통해 처리 

  ##### ①  트랜잭션의 시작

     \- DML 문장이 최초 실행될 때 자동 시작

  ##### ②  트랜잭션의 종료

     \- COMMIT이나 ROLLBACK 명령어 실행

     \- DBMS 클라이언트 정상 종료 시 Auto Commit

     \- DBMS 장애 시 Auto Rollback

     \- DDL이나 DCL 문장의 경우 Auto Commit

![1537257459854](C:\Users\KOSTA\AppData\Local\Temp\1537257459854.png)

##### COMMINT :      변경사항 저장      /     ROLLBACK :       변경사항 취소 

AUTO COMMINT : Commit / rollback 하기 전에 프로그램 종료시, 자동 저장

TRANSACTION : ALL OR NOT 

create ->하면 자동으로 auto commit

* insert 하고 commit을 해주어야 다른 작업이 가능하다!! 
* 변경상태의 행은 LOCK이 설정되어서 COMMIT/ROLLBACK전에 변경 X

##### 사원번호 입력하기 

1_ describe 내용값 확인

2_ sequence & constraints 확인하기

```
-- 마지막 사원번호 입력 
desc employees;
SELECT * FROM user_sequences;
SELECT * FROM user_constraints;

SELECT * 
FROM user_constraints
where table_name = 'EMPLOYEES';

--이메일 반드시! 중복값 X
INSERT INTO employees (EMPLOYEE_id, first_name,	LAST_NAME,	EMAIL, PHONE_NUMBER,	
HIRE_DATE,	JOB_ID	,SALARY ,COMMISSION_PCT ,MANAGER_ID,	DEPARTMENT_ID) 
VALUES  (employees_seq.NEXTVAL, 'Lee' ,'Hyerim','nina3355@naver.com','000-000-0000',
to_date('2018-09-18', 'YYYY-MM-DD'), 'IT_PROG', 50000 ,0.5,NULL , NULL ); 

--DB파일 반영
commit;

-- 확인하기 
select * 
from employees;
```

# DDL 데이터 정의언어

데이터와 구조 정의

- 데이터 베이스 내 객체 생성, 변경 삭제를 위한 SQL명령어

- | DDL    | 내   용                  |
  | ------ | ------------------------ |
  | CREATE | 데이터베이스   객체 생성 |
  | DROP   | 데이터베이스   객체 삭제 |
  | ALTER  | 데이터베이스   객체 변경 |

##### 테이블

테이블은 관계형 데이터 베이스에서 영속적으로 저장하고자 하는 엔티티를 표현하기 위한 기본적인 데이터 저장 단위

![1537259861923](C:\Users\KOSTA\AppData\Local\Temp\1537259861923.png)

#### 테이블 생성 문법

![1537259891231](C:\Users\KOSTA\AppData\Local\Temp\1537259891231.png)

* 스키마 : 구조 골격 

  	=> 사용자 영역안에 객체 저장: 사용자를 기준으로 한다. 

  	=> EX) 강의실 하나를 하나의  스키마로 볼 수 있다. 옆강의실은 다른 스키마

  현재 _ HR 스키마에 존재하고 있는 것이다. 

* 다른 스키마에서 테이블 생성 

* SYS안에는 HR없다! , SYS안에서 employees -> 오류 발생한다. 
* 해결 ] create table hr.employees (스키마를 앞에 적어주어야 )

컬럼명 1. 데이터타입 [디폴트값] + [ 컬럼제약조건]

##### 오라클에 사용가능한 데이터타입

|  DATA TYPE  |                      설    명                      |
| :---------: | :------------------------------------------------: |
| VARCHAR2(n) |         가변 길이 문자 데이터(1~4000byte)          |
|   CHAR(n)   |         고정 길이 문자 데이터(1~2000byte)          |
| NUMBER(p,s) | 전체 p자리 중 소수점 이하 s자리(p:1~38, s:-84~127) |
|    DATE     |                       7Byte                        |
|    LONG     |          가변 길이 문자 데이터(1~2Gbyte)           |
|    CLOB     |          가변 길이 문자 데이터(1~4Gbyte)           |
|    BLOB     |          가변 길이 이진 데이터(1~4Gbyte)           |

- 대부분 varchar2(n) :  문자데이터  -> 4000바이트 
- number (자릿수, 소숫점) : 숫자형식
- date : 내부적으로 7바이트로 저장됨 : 숫자처리된다. 
- LONG : 가변 길이 문자 데이터 -> 2기가 까지 가능 
- CLOB : 가변 길이 문자 데이터 -> 최대 4기가 까지 가능  
  - 대부분은 파일로 저장한다. 
- BLOB : 가변 길이 이진 데이터 -> 최대 4기가 까지 가능 
  - EX) 0101 ~ : 이미지, 동영상의 저장 , 쓸 일 없다. 
  - 현업) 사진 파일은 특정 파일에 저장하고, DB파일에는 PATH저장