
/*
 * (서브쿼리 문제)
 * IT 부서에서 일하는 사원의 이름과 성을 조회한다.
 */

-- IT 부서의 부서번호 조회 = 부서번호 60번
SELECT DEPARTMENT_ID
  FROM DEPARTMENTS
 WHERE DEPARTMENT_NAME = 'IT'
;


-- IT 부서의 부서번호로 사원의 이름과 성을 조회

SELECT FIRST_NAME
     , LAST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 60
;


-- 합치면

SELECT FIRST_NAME
     , LAST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                          FROM DEPARTMENTS
                         WHERE DEPARTMENT_NAME = 'IT')
;


/*
 * 직무명이 'Programmer'인 사원의 이메일을 조회한다.
 */

SELECT EMAIL
  FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID 
 				   FROM JOBS
 				  WHERE JOB_TITLE = 'Programmer')
; 
 

/*
 * 'Beijing' 도시에 있는 부서명을 조회
 */

SELECT DEPARTMENT_NAME 
  FROM DEPARTMENTS
 WHERE LOCATION_ID = (SELECT LOCATION_ID
 					    FROM LOCATIONS
 					   WHERE CITY = 'Beijing')
;


/*
 * 'Canada' 에 있는 모든 도시명을 조회.
 */

SELECT CITY 
  FROM LOCATIONS
 WHERE COUNTRY_ID = (SELECT COUNTRY_ID
 					   FROM COUNTRIES
 					  WHERE COUNTRY_NAME = 'Canada')
;


/*
 * 'United States of America' 국가에 있는
 * 모든 부서명과 부서번호를 조회한다.
 */

-- 두 개가 직접 연결되어 있지 않음.
-- 한 다리 더 건너야 함.

-- 1. 'United States of America' 국가에 있는 <- 이것부터

SELECT COUNTRY_ID -- US
  FROM COUNTRIES
 WHERE COUNTRY_NAME = 'United States of America'
; 


SELECT LOCATION_ID -- 1400, 1500, 1600, 1700
  FROM LOCATIONS
 WHERE COUNTRY_ID = 'US'
;

-- 합치기
SELECT LOCATION_ID -- 1400, 1500, 1600, 1700
  FROM LOCATIONS
 WHERE COUNTRY_ID = (SELECT COUNTRY_ID -- US
                      FROM COUNTRIES
                     WHERE COUNTRY_NAME = 'United States of America')
; 


SELECT DEPARTMENT_NAME
     , DEPARTMENT_ID
  FROM DEPARTMENTS
 WHERE LOCATION_ID = '1400'
    OR LOCATION_ID = '1500'
    OR LOCATION_ID = '1600'
    OR LOCATION_ID = '1700'
;

-- IN으로 줄이기

SELECT DEPARTMENT_NAME
     , DEPARTMENT_ID
  FROM DEPARTMENTS
 WHERE LOCATION_ID IN ('1400', '1500', '1600', '1700')
;

-- 최종

SELECT DEPARTMENT_NAME
     , DEPARTMENT_ID
  FROM DEPARTMENTS
 WHERE LOCATION_ID IN (SELECT LOCATION_ID -- 1400, 1500, 1600, 1700
  					     FROM LOCATIONS
                        WHERE COUNTRY_ID = (SELECT COUNTRY_ID -- US
                                              FROM COUNTRIES
                                             WHERE COUNTRY_NAME = 'United States of America'))
; 


/*
 * EMPLOYEES 와 DEPARTMENTS 를 조인한 결과를
 * 모두 조회
 */

SELECT *
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP  -- 둘을 교집합해라. 교차하는 것만
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID  -- 기준
;
    
 
/*
 * IT 부서에서 일하는 모든 사원들의 이름과 부서장번호를 조회한다.
 */

SELECT EMP.FIRST_NAME
     , DEP.MANAGER_ID
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 WHERE DEP.DEPARTMENT_NAME = 'IT'
;
    

/*
 * 'Seattle'에 존재하는 부서명과 우편번호를 조회한다.
 */

-- 내가 짠 코드
SELECT DEP.DEPARTMENT_NAME, LCT.POSTAL_CODE
  FROM LOCATIONS LCT
 INNER JOIN DEPARTMENTS DEP
    ON LCT.LOCATION_ID = DEP.LOCATION_ID
 WHERE LCT.CITY = 'Seattle'
;

-- 강사님이 짠 코드

SELECT DEP.DEPARTMENT_NAME
     , LOC.POSTAL_CODE
  FROM DEPARTMENTS DEP
 INNER JOIN LOCATIONS LOC
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 WHERE LOC.CITY = 'Seattle'
;

/*
 * 145번 사원이 부서장으로 근무하는 부서에 있는
 * 사원들의 이름과 부서명을 조회한다.
 */

SELECT EMP.FIRST_NAME
     , DEP.DEPARTMENT_NAME 
  FROM EMPLOYEES EMP
 INNER JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 WHERE DEP.MANAGER_ID = 145
;


-- 부서에 있는 사원들 

/*
 * <위의 글 설명>
 * 
 * 한 부서에 여러 명의 사원이 있다.
 * 부서에 있는 사원을 출력하려면?
 * 부서의 있는 사원이 궁금하니깐(부서의 사원을 구하니깐)
 * DEPARTMENT PK로 기준을 잡아야 함.
 */

-- 조인하는 기준을 잘 잡기



/*
 * 직무아이디가 'ST_CLERK'인 사원의
 * 이름, 성, 직무명, 최저연봉 을 조회.
 */

SELECT EMP.LAST_NAME
     , EMP.FIRST_NAME
     , JOB.JOB_TITLE
     , JOB.MIN_SALARY
  FROM EMPLOYEES EMP
 INNER JOIN JOBS JOB
    ON EMP.JOB_ID = JOB.JOB_ID
 WHERE JOB.JOB_ID = 'ST_CLERK'
;


/*
 * 100번 부서장이 근무하는 부서명, 도시명, 우편번호를 조회
 */

SELECT DEP.DEPARTMENT_NAME
     , LOC.CITY
     , LOC.POSTAL_CODE
  FROM DEPARTMENTS DEP
 INNER JOIN LOCATIONS LOC 
    ON DEP.LOCATION_ID = LOC.LOCATION_ID
 WHERE DEP.MANAGER_ID = 100
;


/*
 * 국가 아이디가 'CN'인 주, 도시, 주소와 국가명을 조회.
 */

SELECT LOC.STATE_PROVINCE
	 , LOC.CITY
	 , LOC.STREET_ADDRESS
	 , CTR.COUNTRY_NAME
  FROM LOCATIONS LOC
 INNER JOIN COUNTRIES CTR
    ON LOC.COUNTRY_ID  = CTR.COUNTRY_ID
 WHERE CTR.COUNTRY_ID = 'CN'
;


