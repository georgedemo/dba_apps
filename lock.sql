select 'Alter system kill session ''' || SID || ',' || SERIAL# || '''immediate;', 
INST_ID,SID,SERIAL#,action,USERNAME,OSUSER,MACHINE,MODULE,program,CLIENT_IDENTIFIER,
round(last_call_et/60) idel_tim,process,to_char(LOGON_TIME,'dd/monhh:mm:ss') logon_time, status,sql_id 
from gv$session
where SID in (
SELECT lpad(' ',DECODE(request,0,0,1))
||sid Blocking_Session
FROM GV$LOCK
WHERE id1 IN
(SELECT id1 FROM GV$LOCK WHERE lmode = 0
)
AND lmode = '6'
AND ctime > 60);
/