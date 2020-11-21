select 
	(avg(A * B) 
    - avg(A) * avg(B)) 
    / (sqrt(avg(A * A) 
    - avg(A) * avg(A)) 
    * sqrt(avg(B * B) 
    - avg(B) * avg(B))) 
as pcc
from tab
where (A regexp '[^0-9.]') = 0 
and (B regexp '[^0-9.]') = 0;