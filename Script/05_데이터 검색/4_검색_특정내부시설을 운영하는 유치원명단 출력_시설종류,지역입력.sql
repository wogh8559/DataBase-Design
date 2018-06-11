
TTITLE '특정 시설을 운영하는|유치원명단'
REM **Insert SELECT statement

select a.kind_id 번호 , a.kind_name 이름, a.kind_add 주소, b.fac_type
from 유치원 a, 내부시설 b
where b.fac_type = '&fac_type' and b.kind_id = a.kind_id and a.kind_add like 
'&add%';

TTITLE  OFF
CLEAR COLUMN