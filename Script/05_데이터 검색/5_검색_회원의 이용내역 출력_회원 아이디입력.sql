
TTITLE '이용했던 유치원 명단'
REM **Insert SELECT statement

select a.kind_id 번호, a.kind_name 이름, a.kind_add 주소, a.kind_open 개점시간, a.kind_close 폐점시간
from 유치원 a, 이용내역 b 
where b.mem_id = '&mem_id' AND b.kind_id <> 0 and b.kind_id = a.kind_id ;

TTITLE  OFF
CLEAR COLUMN