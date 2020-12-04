-- INSERT Control Samples into s_sample table if the sampleid doesn't exist.
-- This query depends on u_ghsampleqc table
-- One parameter required: The runid for this flowcell upload
--
-- Notes: This job is used to be done in com.guardanthealth.lims.actions.controls.CreateSeqControlTubes action.

INSERT INTO S_SAMPLE 
(
    S_SAMPLEID
    , SAMPLEDESC
    , SAMPLETYPEID
    , CREATEDT 
    , CREATEBY
    , CREATETOOL
    , MODDT 
    , MODBY
    , MODTOOL
    , U_GHGENEPANELVERSION
) SELECT 
    sqc.sampleid as S_SAMPLEID, 
    'Control' as SAMPLEDESC, 
    'Control' as SAMPLETYPEID,
    sysdate as CREATEDT,
    user as CREATEBY,
    'mulesoft_etl' as CREATETOOL,
    sysdate as MODDT,
    user as MODBY,
    'mulesoft_etl' as MODTOOL,
    'N/A' as U_GHGENEPANELVERSION
FROM 
    (SELECT distinct sampleid as sampleid from u_ghsampleqc where runid='<runid>' and category='control') sqc 
    LEFT JOIN s_sample s on sqc.sampleid = s.s_sampleid 
WHERE s.s_sampleid IS NULL;

