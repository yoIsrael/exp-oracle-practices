SELECT
  TE.SQL_ID,
  TE.PLAN_HASH_VALUE PHV,
  TE.EXECUTIONS-NVL(TS.EXECUTIONS,0) EXECUTIONS,
  TE.FETCHES-NVL(TS.FETCHES,0) FETCHES,
  TE.ROWS_PROCESSED-NVL(TS.ROWS_PROCESSED,0) ROW_PRO,
  TE.BUFFER_GETS-NVL(TS.BUFFER_GETS,0) BUFFER_GETS,
  TE.DISK_READS-NVL(TE.DISK_READS,0) DISK_READS
FROM
  DATALOG.TS_SQLSTATS TS,
  DATALOG.TE_SQLSTATS TE
WHERE
  TE.SQL_ID=TS.SQL_ID(+)
  AND TE.PLAN_HASH_VALUE=TS.PLAN_HASH_VALUE(+)
  AND TE.SQL_ID IN ('4q9qq5mta9t07','cnbgwf9x3mcqj','9bz3rn13xf68a','0pb8dqzx301b4')
ORDER BY
  TE.BUFFER_GETS DESC;