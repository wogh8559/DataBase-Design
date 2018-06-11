
TTITLE '기르는 반려동물이 수강하는|교육코스에 대한 목록'
REM **Insert SELECT statement

select a.course_id 번호, a.course_name 이름, a.edu_dest 목적,c.pet_name 반려동물
from 교육코스 a, 반려동물 c, 수강하다 d 
where c.mem_id = '&mem_id' and c.pet_id = d.pet_id 
and d.course_id = a.course_id;

TTITLE  OFF
CLEAR COLUMN