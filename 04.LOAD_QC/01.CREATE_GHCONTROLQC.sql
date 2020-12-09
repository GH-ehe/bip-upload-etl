
-- Create new u_ghcontrolqc record from new sample qc data
--
-- Parameters:
--      flowcellid

INSERT INTO u_ghcontrolqc 
(
    U_GHCONTROLQCID,
    SAMPLEID,
    FLOWCELLID,
    CONTROLTYPE,
    SUGGESTEDRESULT,
    TEMPLATEFLAG,
    CREATEDT,
    CREATEBY,
    CREATETOOL,
    MODDT,
    MODBY,
    MODTOOL,
    ACTIVEFLAG
) SELECT 
    (SELECT MAX(TO_NUMBER(U_GHCONTROLQCID)) FROM u_ghcontrolqc) + ROW_NUMBER() OVER (ORDER BY s.sampleid) as U_GHCONTROLQCID,
    s.sampleid, 
    '<flowcellid>',   -- FLOWCELLID
    NVL(max(r.reagenttypeid), 'NOTFOUND') as ControlType, -- CONTROLTYPE
    (SELECT 
        CASE count(*) 
            WHEN 0 THEN 'Pass' 
            ELSE 'Fail' 
        END
    FROM u_ghsampleqc t
    WHERE UPPER(t.status) != 'PASS' AND t.sampleid=s.sampleid) AS SuggestedResult,  -- SUGGESTEDRESULT
    'N',                -- TEMPLATEFLAG
    sysdate,            -- CREATEDT
    user,               -- CREATEBY
    'mulesoft_etl',     -- CREATETOOL
    sysdate,            -- MODDT
    user,               -- MODBY
    'mulesoft_etl',     -- MODTOOL
    'Y'                -- ACTIVEFLAG
FROM u_ghsampleqc s 
    LEFT JOIN u_ghsdirgtlot l ON s.sampleid = l.linkkeyid1 
    LEFT JOIN REAGENTLOT r ON l.Reagentlotid = r.reagentlotid
WHERE s.runid = '<runid>'
    AND s.category='control' 
    GROUP BY s.sampleid;
