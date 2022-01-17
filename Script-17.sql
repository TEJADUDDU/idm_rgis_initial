CREATE LOCAL TEMPORARY TABLE TEMP_PW ON COMMIT PRESERVE ROWS AS 
SELECT * FROM EDW_EXTERNAL_INPUT_DATA.IDM_BR_HIER_RGIS
 WHERE 1<>1;

idm_br_hier_rgis

SELECT * FROM TEMP_PW;
 
DROP TABLE TEMP_PW;

INSERT INTO TEMP_PW(
UID
,RGIS_CDE
,CSTDN_CDE
,RGIS_TYPE
,FN
,MN
,LST_NM
,EFFECTIVE_DT
,ROW_PROCESS_DTM
,AUDIT_ID
,SOURCE_SYSTEM_ID)
SELECT 
UID
,RGIS_CDE
,CSTDN_CDE
,RGIS_TYPE
,FN
,MN
,LST_NM
,EFFECTIVE_DT
,ROW_PROCESS_DTM
,AUDIT_ID
,SOURCE_SYSTEM_ID
FROM(SELECT 
UID                                          AS UID
,RGIS_CDE                                     AS RGIS_CDE
,CSTDN_CDE                                    AS CSTDN_CDE
,RGIS_TYPE                                    AS RGIS_TYPE
,Frst_NM                                           AS FN
,MID_NM                                         AS MN
,LST_NM                                       AS LST_NM
,rec_strt_dt                                  AS EFFECTIVE_DT
,CURRENT_TIMESTAMP(6)                         AS ROW_PROCESS_DTM                                                    
,-1                                           AS AUDIT_ID
,CLEAN_STRING('15')                           AS SOURCE_SYSTEM_ID
FROM prod_pdcr_hier_vw_tersun.HIER_RGIS_VW)A;


--duplicate_values

select uid,rgis_cde,cstdn_cde,fn,mn,lst_nm,count(*)
from   TEMP_PW
group by uid,rgis_cde,cstdn_cde,fn,mn,lst_nm
having count(*) > 1
order by count(*) asc;



CREATE LOCAL TEMPORARY TABLE TEMP_1 ON COMMIT PRESERVE ROWS AS 
SELECT * FROM EDW_EXTERNAL_INPUT_DATA.IDM_BR_HIER_RGIS
 WHERE 1<>1;


INSERT INTO TEMP_1(
UID
,RGIS_CDE
,CSTDN_CDE
,RGIS_TYPE
,FN
,MN
,LST_NM
,EFFECTIVE_DT
,ROW_PROCESS_DTM
,AUDIT_ID
,SOURCE_SYSTEM_ID)
SELECT 
UID
,RGIS_CDE
,CSTDN_CDE
,RGIS_TYPE
,FN
,MN
,LST_NM
,EFFECTIVE_DT
,ROW_PROCESS_DTM
,AUDIT_ID
,SOURCE_SYSTEM_ID
FROM(SELECT 
UID                                          AS UID
,RGIS_CDE                                     AS RGIS_CDE
,CSTDN_CDE                                    AS CSTDN_CDE
,RGIS_TYPE                                    AS RGIS_TYPE
,Frst_NM                                           AS FN
,MID_NM                                         AS MN
,LST_NM                                       AS LST_NM
,max(rec_strt_dt)                                  AS EFFECTIVE_DT
,CURRENT_TIMESTAMP(6)                         AS ROW_PROCESS_DTM                                                    
,-1                                           AS AUDIT_ID
,CLEAN_STRING('15')                           AS SOURCE_SYSTEM_ID
FROM prod_pdcr_hier_vw_tersun.HIER_RGIS_VW
group by uid,rgis_cde,cstdn_cde,rgis_type,fn,mn,lst_nm)C;

select * from temp_1 limit 10;    
 
