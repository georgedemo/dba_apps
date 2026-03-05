select owner,OBJECT_NAME,OBJECT_TYPE,CREATED, LAST_DDL_TIME, TIMESTAMP, STATUS from dba_objects where status='INVALID'
order by last_ddl_time desc;