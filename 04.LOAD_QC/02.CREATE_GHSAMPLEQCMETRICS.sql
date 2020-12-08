-- Create new u_GHSampleQCMetrics record for TubeType Control from Sample QC
--
-- Parameters:
--      flowcellid

INSERT INTO u_GHSampleQCMetrics 
(
    U_GHSAMPLEQCMETRICSID,
    ACCESSIONID,
    FLOWCELLID,
    TUBETYPE,
    SUGGESTEDRESULT,
    FINALRESULT,
    TEMPLATEFLAG,
    CREATEDT,
    CREATEBY,
    CREATETOOL,
    MODDT,
    MODBY,
    MODTOOL,
    ACTIVEFLAG
) SELECT 
    (SELECT MAX(TO_NUMBER(U_GHSAMPLEQCMETRICSID)) FROM u_GHSampleQCMetrics) + ROW_NUMBER() OVER (ORDER BY ACCESSIONID) as U_GHSAMPLEQCMETRICSID,
    ACCESSIONID, 
    FLOWCELLID,
    'Control' as TUBETYPE,          -- TUBETYPE
    SUGGESTEDRESULT,
    SUGGESTEDRESULT AS FINALRESULT,
    'N',                -- TEMPLATEFLAG
    sysdate,            -- CREATEDT
    user,               -- CREATEBY
    'mulesoft_etl',     -- CREATETOOL
    sysdate,            -- MODDT
    user,               -- MODBY
    'mulesoft_etl',     -- MODTOOL
    'Y'                -- ACTIVEFLAG
FROM (
    SELECT 
        s.sampleid as ACCESSIONID, 
        '<flowcellid>' as FLOWCELLID,     -- FLOWCELLID
        (SELECT 
            CASE count(*) 
                WHEN 0 THEN 'Pass' 
                ELSE 'Fail' 
            END
        FROM u_ghsampleqc t
        WHERE UPPER(t.status) != 'PASS' AND t.sampleid=s.sampleid) AS SUGGESTEDRESULT
    FROM u_ghsampleqc s 
    WHERE s.runid like '%<flowcellid>'
        AND s.category='control' 
        GROUP BY s.sampleid
);


-- Create new u_GHSampleQCMetrics record for TubeType Sample from Sample QC

INSERT INTO u_GHSampleQCMetrics 
(
    U_GHSAMPLEQCMETRICSID,
    ACCESSIONID,
    FLOWCELLID,
    TUBETYPE,
    SUGGESTEDRESULT,
    FINALRESULT,
    FAILEDFIELDS,
    TEMPLATEFLAG,
    CREATEDT,
    CREATEBY,
    CREATETOOL,
    MODDT,
    MODBY,
    MODTOOL,
    ACTIVEFLAG,
    SECURITYDEPARTMENT
) SELECT 
    (SELECT MAX(TO_NUMBER(U_GHSAMPLEQCMETRICSID)) FROM u_GHSampleQCMetrics) + ROW_NUMBER() OVER (ORDER BY ACCESSIONID) as U_GHSAMPLEQCMETRICSID,
    ACCESSIONID, 
    FLOWCELLID,
    'Sample' as TUBETYPE,   -- TUBETYPE
    SUGGESTEDRESULT,        -- SUGGESTEDRESULT
    SUGGESTEDRESULT AS FINALRESULT, -- FINALRESULT
    CASE SUGGESTEDRESULT 
        WHEN NULL THEN 'Cannot find sample_autoqc_total in QC Parameter list' 
        ELSE '' 
    END AS FAILEDFIELDS,    -- FAILEDFIELDS
    'N',                    -- TEMPLATEFLAG
    sysdate,                -- CREATEDT
    user,                   -- CREATEBY
    'mulesoft_etl',         -- CREATETOOL
    sysdate,                -- MODDT
    user,                   -- MODBY
    'mulesoft_etl',         -- MODTOOL
    'Y',                    -- ACTIVEFLAG
    SECURITYDEPARTMENT
FROM (
 SELECT 
    sampleid AS ACCESSIONID,
    'VV323LBCXY' AS FLOWCELLID,
    (SELECT 
        CASE upper(status) 
        WHEN 'PASS' THEN 'Pass'
        WHEN 'FAIL' THEN 'Fail'
        WHEN 'REVIEW' THEN 'Review'
        ELSE 'Invalid Value for sample_autoqc_total: ' || NVL(status, 'NULL')
        END
        FROM u_ghsampleqc
        WHERE 
            sampleid = qc.sampleid
            AND metric = 'sample_autoqc_total'
            ORDER BY sampleid desc
            FETCH FIRST ROW ONLY) AS SUGGESTEDRESULT,
        MAX(s.SECURITYDEPARTMENT) AS SECURITYDEPARTMENT
    FROM 
        u_ghsampleqc qc JOIN s_sample s ON qc.sampleid = s.s_sampleid 
    WHERE qc.runid like '%VV323LBCXY' 
        AND qc.category='sample' 
        GROUP BY qc.sampleid
);