select  a.TABLESPACE_NAME,
        a.BYTES/1024/1024 "Used Size(MB)",
        b.BYTES/1024/1024 "Free Size(MB)",
        round(((a.BYTES-b.BYTES)/a.BYTES)*100,2) percent_used
from
        (
                select  TABLESPACE_NAME,
                        sum(BYTES) BYTES
                from    dba_data_files
                group   by TABLESPACE_NAME
        )a,
        (
                select  TABLESPACE_NAME,
                        sum(BYTES) BYTES ,
                        max(BYTES) largest
                from    dba_free_space
                group   by TABLESPACE_NAME
        )b
where   a.TABLESPACE_NAME=b.TABLESPACE_NAME
and round(((a.BYTES-b.BYTES)/a.BYTES)*100,2)>=91
and a.tablespace_name !='SYSAUX';
