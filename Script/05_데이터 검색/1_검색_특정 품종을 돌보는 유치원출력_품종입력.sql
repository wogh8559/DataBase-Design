
TTITLE '특정 품종을 기르는|유치원 명단'
REM **Insert SELECT statement
select c.kind_id 번호, c.kind_name 이름, c.kind_add 주소, c.kind_tel 연락처, c.kind_open 개점, c.kind_close 폐점
from 등록하다 b, 유치원 c 
where b.pet_id IN (select pet_id from 반려동물 where pet_breed = '&pet_breed') and  b.kind_id = c.kind_Id ;
TTITLE  OFF
CLEAR COLUMN