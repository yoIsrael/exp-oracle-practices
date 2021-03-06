SET AUTOTRACE TRACEONLY EXPLAIN

SELECT
  TOP_LEVEL_PART_ID, REQ.PURC_PART_ID, REQ.TOTAL_QTY,
  REQ.TOTAL_QTY*TPPD.INCREASE "Increase",
  REQ.R1_PART_ID, REQ.R2_PART_ID, REQ.R3_PART_ID,
  REQ.R4_PART_ID, REQ.R5_PART_ID, REQ.R6_PART_ID,
  REQ.R1_CALC_QTY, REQ.R2_CALC_QTY, REQ.R3_CALC_QTY,
  REQ.R4_CALC_QTY, REQ.R5_CALC_QTY, REQ.R6_CALC_QTY
FROM
  (SELECT
    TOP_LEVEL_PART_ID,
    DECODE(R6_PART_ID,NULL,
      DECODE(R5_PART_ID,NULL,
        DECODE(R4_PART_ID,NULL,
          DECODE(R3_PART_ID,NULL,
            DECODE(R2_PART_ID,NULL,
                   R1_PART_ID,R2_PART_ID),
                 R3_PART_ID),
               R4_PART_ID),
             R5_PART_ID),
           R6_PART_ID) PURC_PART_ID,
    NVL(R1_CALC_QTY,0)*NVL(R2_CALC_QTY,1)*NVL(R3_CALC_QTY,1)*NVL(R4_CALC_QTY,1)*NVL(R5_CALC_QTY,1)*NVL(R6_CALC_QTY,1) TOTAL_QTY,
    R1_PART_ID, R1_CALC_QTY, R2_PART_ID, R2_CALC_QTY, R3_PART_ID, R3_CALC_QTY,
    R4_PART_ID, R4_CALC_QTY, R5_PART_ID, R5_CALC_QTY, R6_PART_ID, R6_CALC_QTY
  FROM
    (SELECT
      PL.PART_ID TOP_LEVEL_PART_ID,
      DECODE(R6.PART_ID,NULL,
        DECODE(R5.PART_ID,NULL,
          DECODE(R4.PART_ID,NULL,
            DECODE(R3.PART_ID,NULL,
              DECODE(R2.PART_ID,NULL,
                     R.PART_ID,R2.PART_ID),
                   R3.PART_ID),
                 R4.PART_ID),
               R5.PART_ID),
             R6.PART_ID) PURC_PART_ID,
      NVL(R.CALC_QTY,0)*NVL(R2.CALC_QTY,1)*NVL(R3.CALC_QTY,1)*NVL(R4.CALC_QTY,1)*NVL(R5.CALC_QTY,1)*NVL(R6.CALC_QTY,1) TOTAL_QTY,
      R.PART_ID R1_PART_ID,
      R.CALC_QTY R1_CALC_QTY,
      DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL) R2_PART_ID,
      DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.CALC_QTY,NULL) R2_CALC_QTY,
      DECODE(
        DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
        NULL,
        NULL,
        DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.PART_ID,NULL)) R3_PART_ID,
      DECODE(
        DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
        NULL,
        NULL,
        DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.CALC_QTY,NULL)) R3_CALC_QTY,
      DECODE(
        DECODE(
          DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
          NULL,
          NULL,
          DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.PART_ID,NULL)),
        NULL,
        NULL,
        DECODE(NVL(P3.FABRICATED,'NONE'),'Y',R4.PART_ID,NULL)) R4_PART_ID,
      DECODE(
        DECODE(
          DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
          NULL,
          NULL,
          DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.PART_ID,NULL)),
        NULL,
        NULL,
        DECODE(NVL(P3.FABRICATED,'NONE'),'Y',R4.CALC_QTY,NULL)) R4_CALC_QTY,
      DECODE(
        DECODE(
          DECODE(
            DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
            NULL,
            NULL,
            DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.PART_ID,NULL)),
          NULL,
          NULL,
          DECODE(NVL(P3.FABRICATED,'NONE'),'Y',R4.PART_ID,NULL)),
        NULL,
        NULL,
        DECODE(NVL(P4.FABRICATED,'NONE'),'Y',R5.PART_ID,NULL)) R5_PART_ID,
      DECODE(
        DECODE(
          DECODE(
            DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
            NULL,
            NULL,
            DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.PART_ID,NULL)),
          NULL,
          NULL,
          DECODE(NVL(P3.FABRICATED,'NONE'),'Y',R4.PART_ID,NULL)),
        NULL,
        NULL,
        DECODE(NVL(P4.FABRICATED,'NONE'),'Y',R5.CALC_QTY,NULL)) R5_CALC_QTY,
      DECODE(
        DECODE(
          DECODE(
            DECODE(
              DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
              NULL,
              NULL,
              DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.PART_ID,NULL)),
            NULL,
            NULL,
            DECODE(NVL(P3.FABRICATED,'NONE'),'Y',R4.PART_ID,NULL)),
          NULL,
          NULL,
          DECODE(NVL(P4.FABRICATED,'NONE'),'Y',R5.PART_ID,NULL)),
        NULL,
        NULL,
        DECODE(NVL(P5.FABRICATED,'NONE'),'Y',R6.PART_ID,NULL)) R6_PART_ID,
      DECODE(
        DECODE(
          DECODE(
            DECODE(
              DECODE(NVL(P.FABRICATED,'NONE'),'Y',R2.PART_ID,NULL),
              NULL,
              NULL,
              DECODE(NVL(P2.FABRICATED,'NONE'),'Y',R3.PART_ID,NULL)),
            NULL,
            NULL,
            DECODE(NVL(P3.FABRICATED,'NONE'),'Y',R4.PART_ID,NULL)),
          NULL,
          NULL,
          DECODE(NVL(P4.FABRICATED,'NONE'),'Y',R5.PART_ID,NULL)),
        NULL,
        NULL,
        DECODE(NVL(P5.FABRICATED,'NONE'),'Y',R6.CALC_QTY,NULL)) R6_CALC_QTY
    FROM
      REQUIREMENT R, REQUIREMENT R2, REQUIREMENT R3,
      REQUIREMENT R4, REQUIREMENT R5, REQUIREMENT R6,
      PART P, PART P2, PART P3, PART P4, PART P5, PART P6,
      (SELECT DISTINCT
        COL.PART_ID
      FROM
        CUSTOMER_ORDER CO,
        CUST_ORDER_LINE COL
      WHERE
        CO.STATUS IN ('F','R','U','P','C')
        AND CO.ID=COL.CUST_ORDER_ID
        AND COL.DESIRED_SHIP_DATE>(SYSDATE-365)) PL
    WHERE
      R.WORKORDER_TYPE='M'
      AND PL.PART_ID=R.WORKORDER_BASE_ID
      AND R.WORKORDER_LOT_ID='0'
      AND R.WORKORDER_SPLIT_ID='0'
      AND R.SUBORD_WO_SUB_ID IS NULL
      AND R.PART_ID=P.ID(+)
      AND P.FABRICATED(+)='Y'
      AND R2.WORKORDER_TYPE(+)='M'
      AND R.PART_ID=R2.WORKORDER_BASE_ID(+)
      AND R2.WORKORDER_LOT_ID(+)='0'
      AND R2.SUBORD_WO_SUB_ID IS NULL
      AND R2.PART_ID=P2.ID(+)
      AND P2.FABRICATED(+)='Y'
      AND R3.WORKORDER_TYPE(+)='M'
      AND R2.PART_ID=R3.WORKORDER_BASE_ID(+)
      AND R3.WORKORDER_LOT_ID(+)='0'
      AND R3.SUBORD_WO_SUB_ID IS NULL
      AND R3.PART_ID=P3.ID(+)
      AND P3.FABRICATED(+)='Y'
      AND R4.WORKORDER_TYPE(+)='M'
      AND R3.PART_ID=R4.WORKORDER_BASE_ID(+)
      AND R4.WORKORDER_LOT_ID(+)='0'
      AND R4.SUBORD_WO_SUB_ID IS NULL
      AND R4.PART_ID=P4.ID(+)
      AND P4.FABRICATED(+)='Y'
      AND R5.WORKORDER_TYPE(+)='M'
      AND R4.PART_ID=R5.WORKORDER_BASE_ID(+)
      AND R5.WORKORDER_LOT_ID(+)='0'
      AND R5.SUBORD_WO_SUB_ID IS NULL
      AND R5.PART_ID=P5.ID(+)
      AND P5.FABRICATED(+)='Y'
      AND R6.WORKORDER_TYPE(+)='M'
      AND R5.PART_ID=R6.WORKORDER_BASE_ID(+)
      AND R6.WORKORDER_LOT_ID(+)='0'
      AND R6.SUBORD_WO_SUB_ID IS NULL
      AND R6.PART_ID=P6.ID(+)
      AND P6.FABRICATED(+)='Y')) REQ,
  TEMP_PART_PRICE_DATE TPPD
WHERE
  REQ.PURC_PART_ID=TPPD.PART_ID
  AND TPPD.INCREASE<>0;
