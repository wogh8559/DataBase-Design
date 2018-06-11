
UPDATE 직원
SET  staff_salary = staff_salary + &money
WHERE kind_id = &유치원번호 AND 
      staff_id IN ( SELECT staff_id
		   FROM   직원
  	           WHERE staff_hiredate <'&고용일자');