
TTITLE '특정 교육코스를 개설한|유치원명단'
REM **Insert SELECT statement

select a.kind_id 번호, a.kind_name 이름, a.kind_add 주소, a.kind_tel 연락처, c.course_name 코스명
from 유치원 a, 개설하다 b, 교육코스 c
where c.course_name = '&course_name' and b.course_id = c.course_id and b.kind_id = a.kind_id ;

TTITLE  OFF
CLEAR COLUMN