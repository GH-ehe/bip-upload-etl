-- 1. Remove all existing data blong to this flowcell
-- Parameters:
--    
--
DELETE FROM u_ghsampleqc WHERE RUNID = '<runid>';

-- 2. Insert data
INSERT INTO u_ghsampleqc (
    U_GHSAMPLEQCID,
    GHSAMPLEQCDESC,
    TRACELOGID,
    TEMPLATEFLAG,
    NOTES,
    CREATEDT,
    CREATEBY,
    CREATETOOL,
    MODDT,
    MODBY,
    MODTOOL,
    ACTIVEFLAG,
    SAMPLEID,
    RUNID,
    CATEGORY,
    METRIC,
    VERBOSENAME,
    UNIT,
    VALUE,
    OPERATOR,
    THRESHOLD,
    STATUS
) VALUES (
    (select lpad(max(U_GHSAMPLEQCID) + 1, 8, '0') from u_ghsampleqc),
    NULL,               -- GHSAMPLEQCDESC
    NULL,               -- TRACELOGID
    'N',                -- TEMPLATEFLAG
    NULL,               -- NOTES
    sysdate,            -- CREATEDT
    user,               -- CREATEBY
    'mulesoft_etl',     -- CREATETOOL
    sysdate,            -- MODDT
    user,               -- MODBY
    'mulesoft_etl',     -- MODTOOL
    'Y',                -- ACTIVEFLAG
    '<run_sample_id>',  -- SAMPLEID
    '<runid>',          -- RUNID
    '<category>',       -- CATEGORY
    '<metric>',         -- METRIC
    '<verbose_name>',   -- VERBOSENAME
    '<unit>',           -- UNIT
    <value>,            -- VALUE
    '<operator>',       -- OPERATOR
    <threshold>,        -- THRESHOLD
    '<status>'          -- STATUS
);