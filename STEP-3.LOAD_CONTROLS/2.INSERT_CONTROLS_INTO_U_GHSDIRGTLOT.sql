-- INSERT Control Samples into U_GHSDIRGTLOT table if the sampleid doesn't exist.
-- This query depends on u_ghsampleqc table
-- One parameter required: The runid for this flowcell upload
--
-- Notes: This job is used to be done in com.guardanthealth.lims.actions.controls.CreateSeqControlTubes action.

INSERT INTO U_GHSDIRGTLOT
(   
    U_GHSDIRGTLOTID
    ,GHSDIRGTLOTDESC
    ,USERSEQUENCE
    ,AUDITSEQUENCE
    ,TRACELOGID
    ,TEMPLATEFLAG
    ,NOTES
    ,CREATEDT
    ,CREATEBY
    ,CREATETOOL
    ,MODDT
    ,MODBY
    ,MODTOOL
    ,ACTIVEFLAG
    ,REAGENTLOTID
    ,LINKSDCID
    ,LINKKEYID1
) SELECT  
    (SELECT LPAD(MAX(U_GHSDIRGTLOTID) + 1, 7, '0') FROM U_GHSDIRGTLOT) as U_GHSDIRGTLOTID,
    NULL as GHSDIRGTLOTDESC,
    NULL as USERSEQUENCE,
    NULL as AUDITSEQUENCE,
    NULL as TRACELOGID,
    'N'  as TEMPLATEFLAG,
    NULL as NOTES,
    sysdate as CREATEDT,
    user as CREATEBY,
    'mulesoft_etl' as CREATETOOL,
    sysdate as MODDT,
    user as MODBY,
    'mulesoft_etl' as MODTOOL,
    'Y' as ACTIVEFLAG,
    'N/A' as REAGENTLOTID,      -- Constant `N/A` should be used for creating new record
    'Sample' as LINKSDCID,
    sqc.sampleid as LINKKEYID1
FROM
    (SELECT distinct sampleid as sampleid from u_ghsampleqc where runid='<runid>' and category='control') sqc 
    LEFT JOIN u_ghsdirgtlot rgtlot on sqc.sampleid = rgtlot.linkkeyid1
WHERE rgtlot.linkkeyid1 IS NULL;