
CREATE TABLE 유치원(
 	kind_id 	NUMBER(4),
	 kind_name 	VARCHAR2(20) NOT NULL,
	 kind_pre 	VARCHAR2(10) NOT NULL,
	 kind_add 	VARCHAR2(60) NOT NULL,
	 kind_tel 	VARCHAR2(13) NOT NULL,
	 kind_open 	VARCHAR2(6)  NOT NULL,
	 kind_close	VARCHAR2(6)  NOT NULL,
	 hos_id 	NUMBER(4),                  
	 CONSTRAINT      유치원_PK  PRIMARY KEY(kind_id),
	 CONSTRAINT      kind_tel_UK  UNIQUE(kind_tel)
);

commit;

CREATE TABLE 교사 ( 
	 teacher_id             NUMBER(4)    	     ,
 	 teacher_name           VARCHAR2(20) NOT NULL, 
	 teacher_call           VARCHAR2(13) NOT NULL,
	 teacher_career         VARCHAR2(5)	     , 
	 teacher_salary         NUMBER(7)    NOT NULL,
	 hire_date              VARCHAR2(8)	     ,  
	 kind_id                NUMBER(4)    NOT NULL,

	CONSTRAINT  교사_PK     	            PRIMARY KEY(teacher_id),
	CONSTRAINT  teacher_kind_id_FK	 	    FOREIGN KEY(kind_id)    REFERENCES  유치원(kind_id) ON DELETE CASCADE
);

commit;

CREATE TABLE 교사자격증 ( 
 	teacher_id             NUMBER(4) 	    ,
 	teacher_license        VARCHAR2(20)         , 

	CONSTRAINT  교사자격증_PK      PRIMARY KEY(teacher_id,teacher_license ),
	CONSTRAINT  licence_teacher_id_FK      FOREIGN KEY (teacher_id)    REFERENCES  교사(teacher_id) ON DELETE CASCADE
);

commit;

CREATE TABLE 내부시설 ( 
	 fac_id             NUMBER(4) 		 	  ,  
	 fac_type           VARCHAR2(10) NOT NULL         , 
	 fac_pos            VARCHAR2(10) NOT NULL         ,
	 fac_call           VARCHAR2(13) NOT NULL         ,
	 fac_open           VARCHAR2(6)  NOT NULL	  ,
	 fac_close          VARCHAR2(6)  NOT NULL	  ,
	 kind_id            NUMBER(4)    NOT NULL         ,

	CONSTRAINT	    내부시설_PK    	 PRIMARY KEY(fac_id),
	CONSTRAINT          fac_kind_id_FK   	 FOREIGN KEY (kind_id)    REFERENCES  유치원(kind_id) ON DELETE CASCADE
);

commit;

CREATE TABLE 직원 ( 
 	 staff_id             NUMBER(4)    		  ,
	 staff_name           VARCHAR2(10)	  NOT NULL, 
	 staff_salary         NUMBER(7)	   	  NOT NULL, 
	 staff_tel            VARCHAR2(13) 	  NOT NULL,
	 staff_hiredate       VARCHAR2(8)  	  NOT NULL,
	 kind_id              NUMBER(4)  	  NOT NULL,

	CONSTRAINT  	      직원_PK     		PRIMARY KEY(staff_id),
	CONSTRAINT  	      staff_kind_id_FK   	FOREIGN KEY(kind_id)    REFERENCES  유치원(kind_id) ON DELETE CASCADE
);

commit;

CREATE TABLE 관리하다(
	staff_id		NUMBER(4),
	fac_id   		NUMBER(4),
	super_day 		VARCHAR2(6),
	
	CONSTRAINT 관리하다_PK 	    PRIMARY KEY(staff_id, fac_id, super_day),
	CONSTRAINT sup_staff_id_FK      FOREIGN KEY (staff_id)	REFERENCES  직원(staff_id) ON DELETE CASCADE,
	CONSTRAINT sup_fac_id_FK        FOREIGN KEY (fac_id)   	REFERENCES  내부시설(fac_id) ON DELETE CASCADE
 ); 

commit; 

CREATE TABLE 동물병원 ( 
 	 hos_id          	NUMBER(4),
	 hos_name               VARCHAR2(20)  	NOT  NULL,
	 hos_pos             	VARCHAR2(10)  	NOT  NULL, 
	 hos_call          	VARCHAR2(13)  	NOT  NULL,
	 hos_addr             	VARCHAR2(60) 	NOT  NULL,
	 hos_open          	VARCHAR2(6)     NOT  NULL,
	 hos_close          	VARCHAR2(6)     NOT  NULL,
	
	 CONSTRAINT  동물병원_PK    PRIMARY KEY (hos_id),
	 CONSTRAINT  hos_call_UK    UNIQUE(hos_call) 
);

commit;

ALTER TABLE  유치원
 ADD   CONSTRAINT hos_id_FK   FOREIGN KEY (hos_id)  REFERENCES  동물병원(hos_id) ON DELETE CASCADE ; 

CREATE TABLE 셔틀버스( 
	 bus_id                 NUMBER(4)  DEFAULT(0)	, 
  	 kind_id                NUMBER(4)		, 
	 bus_cont               VARCHAR2(20)		,    
	 bus_pay                NUMBER(7)		,         
	 bus_call	        VARCHAR2(13)		,
	 bus_num                NUMBER(2)		, 
	 bus_run 		VARCHAR(2) DEFAULT('N')  CHECK(bus_run in('Y','N')) ,

	 CONSTRAINT  셔틀버스_PK    PRIMARY KEY (bus_id, kind_id),
	 CONSTRAINT  bus_kind_id_FK     FOREIGN KEY (kind_id) 		REFERENCES  유치원(kind_id) ON DELETE CASCADE
);

commit;

CREATE TABLE 셔틀버스시간( 
	 bus_id                 NUMBER(4),
	 kind_id                NUMBER(4),
	 bus_time               VARCHAR2(4),
	 
 
	 CONSTRAINT  셔틀버스시간_PK   PRIMARY KEY ( bus_id,  kind_id, bus_time),
	 CONSTRAINT  time_bus_kind_id_FK    FOREIGN KEY (kind_id,bus_id)             REFERENCES  셔틀버스(kind_id,bus_id) ON DELETE CASCADE
	 
);

commit;     

CREATE TABLE 보호자(
	mem_id varchar2(20),             
	mem_name varchar2(10) not null,
	mem_add varchar2(60) not null,  
	mem_tel varchar2(13) not null,   
	CONSTRAINT 보호자_PK primary key(mem_id)
);

commit;

CREATE TABLE 이용내역(
	kind_id number(4)   DEFAULT(0),
	mem_id varchar2(20),              
	CONSTRAINT 이용내역_PK 	   primary key(kind_id, mem_id),
	CONSTRAINT past_kind_id_FK      FOREIGN KEY(kind_id)    REFERENCES  유치원(kind_id) ON DELETE CASCADE,
	CONSTRAINT past_mem_id_FK       FOREIGN KEY(mem_id)    REFERENCES  보호자(mem_id) ON DELETE CASCADE
);

commit;

CREATE TABLE 반려동물(
	pet_id number(4),     
	pet_name varchar2(10) not null,
	pet_age number(2) not null,         
	pet_weight number(2) not null,       
	pet_breed varchar2(20) not null,
	pet_gender varchar2(1) not null CHECK(pet_gender in ('M','W','T')),      
	mem_id varchar2(20) not null,         
	CONSTRAINT 반려동물_PK primary key(pet_id),
	CONSTRAINT pet_mem_id_FK   FOREIGN KEY(mem_id)    REFERENCES  보호자(mem_id) ON DELETE CASCADE
);

commit; 

CREATE TABLE 반려동물병력사항(
	med_his varchar2(30),                  
	pet_id number(4),               
	CONSTRAINT 반려동물병력사항_PK primary key(med_his, pet_id),
	CONSTRAINT dis_pet_id_FK   FOREIGN KEY(pet_id)    REFERENCES  반려동물(pet_id) ON DELETE CASCADE
);

commit;

CREATE TABLE 교육코스( 
	 course_id             NUMBER(4) 	        ,
	 course_name           VARCHAR2(20) 	NOT NULL, 
	 edu_dest              VARCHAR2(60) 	NOT NULL, 
	
	CONSTRAINT  교육코스_PK     PRIMARY KEY(course_id) 
);

commit; 

CREATE TABLE 담당하다 ( 
	teacher_id  	NUMBER(4)	,
	course_id  	NUMBER(4)	,
	start_date  	VARCHAR2(8)	, 

	CONSTRAINT  담당하다_PK     PRIMARY KEY(teacher_id, course_id, start_date),
	CONSTRAINT  teach_teacher_id_FK   FOREIGN KEY (teacher_id) 	REFERENCES  교사(teacher_id) ON DELETE CASCADE,
	CONSTRAINT  teach_course_id_FK    FOREIGN KEY (course_id) 	REFERENCES  교육코스(course_id) ON DELETE CASCADE
); 

commit; 

CREATE TABLE 개설하다 (	
	course_id	NUMBER(4),
	course_start	VARCHAR2(8),
	kind_id		NUMBER(4),
	edu_pay         NUMBER(7)	NOT NULL,
	min_num         NUMBER(2) 	NOT NULL,
	max_num         NUMBER(2) 	NOT NULL,
	apply_num	NUMBER(2)		,
	open_do		VARCHAR2(2)     DEFAULT('N')  CHECK(open_do in('Y','N')),
	
		
	CONSTRAINT 개설하다_PK 	         PRIMARY KEY(course_id, course_start, kind_id),
	CONSTRAINT open_kind_id_FK       FOREIGN KEY (kind_id)	REFERENCES  유치원(kind_id) ON DELETE CASCADE,
	CONSTRAINT open_course_id_FK     FOREIGN KEY (course_id)   	REFERENCES  교육코스(course_id)	ON DELETE CASCADE 
 );

commit;

CREATE TABLE 수강하다(
	pet_id	    	NUMBER(4),
	course_id   	NUMBER(4),
	course_start 	VARCHAR2(8),

	CONSTRAINT 수강하다_PK	    PRIMARY KEY(pet_id, course_id, course_start),
	CONSTRAINT lis_pet_id_FK        FOREIGN KEY (pet_id) 	REFERENCES  반려동물(pet_id) ON DELETE CASCADE,
	CONSTRAINT lis_course_id_FK     FOREIGN KEY (course_id) 	REFERENCES  교육코스(course_id)	ON DELETE CASCADE
); 

commit;

CREATE TABLE 등록하다(	
	kind_id		NUMBER(4),
	mem_id		VARCHAR2(20),
	pet_id		NUMBER(4),
	start_day	VARCHAR2(8),
	pay_do		VARCHAR2(2) DEFAULT('N') CHECK(pay_do in('Y','N')) ,

	CONSTRAINT 등록하다_PK      PRIMARY KEY(kind_id, mem_id,start_day,pet_id),
	CONSTRAINT reg_kind_id_FK       FOREIGN KEY (kind_id)	REFERENCES  유치원(kind_id) ON DELETE CASCADE,
	CONSTRAINT reg_mem_id_FK        FOREIGN KEY (mem_id)   	REFERENCES  보호자(mem_id) ON DELETE CASCADE,
	CONSTRAINT reg_pet_id_FK        FOREIGN KEY (pet_id)	REFERENCES  반려동물(pet_id) ON DELETE CASCADE
);

commit;

CREATE SEQUENCE kind_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
;

CREATE SEQUENCE pet_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
;

CREATE SEQUENCE fac_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
;

CREATE SEQUENCE staff_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
;

CREATE SEQUENCE teacher_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
	;

CREATE SEQUENCE course_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
	
;

CREATE SEQUENCE hospital_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
	;

 CREATE SEQUENCE bus_seq
	start with 1
	maxvalue 9999
	increment by 1
	nocycle
	;