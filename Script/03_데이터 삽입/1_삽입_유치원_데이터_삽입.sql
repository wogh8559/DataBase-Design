
ACCEPT  kind_name   PROMPT  '유치원 이름을 입력하시오 : '
ACCEPT  kind_pre    PROMPT  '대표자명을 입력하시오    : '
ACCEPT  kind_add    PROMPT  '주소를 입력하시오 	  : '
ACCEPT  kind_tel    PROMPT  '연락처를 입력하시오	  : '
ACCEPT  kind_open   PROMPT  '개점시간를 입력하시오 :'
ACCEPT  kind_close  PROMPT  '폐점시간를 입력하시오 :'
ACCEPT  hos_id      PROMPT  '협력병원번호를 입력하시오 :'

INSERT INTO  유치원 
VALUES(kind_seq.nextval,'&kind_name','&kind_pre','&kind_add','&kind_tel','&kind_open','&kind_close','&hos_id');



