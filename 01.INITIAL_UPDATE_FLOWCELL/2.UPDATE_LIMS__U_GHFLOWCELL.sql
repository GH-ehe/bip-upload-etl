-- Update LIMS u_ghflowcell table with the data retrieved from GHDB.gh_flowcell.
-- Here are some assumptions:
--      1. A record for this flowcellid must have been created in the LIMS.u_ghflowcell table.
--      2. The LIMS BIP Upload module takes the responsiblities to verify if the flowcell is qualified for BIP upload job before it sends the message to ETL
--      3. Flowcellis is the unique key
--
--
--  <column_name> - The column_name in the GHDB query, so we can map its value to LIMS database column.
--

UPDATE u_ghflowcell 
SET
    ACTIVEFLAG          = 'Y',
    AIO_CONTROLS        = NULL,
    AUDITSEQUENCE       = NULL,
    AUTOQCTOTAL         = NULL,
    BIPVERSION          = '<bip_version>',
    BOLTONVERSION       = '<boltonversion>',
    COMMENTS            = '<comment>',
    CREATEBY            = lower(user),
    CREATEDT            = sysdate,
    CREATETOOL          = 'mulesoft_etl',
    FAILEDFIELDS        = NULL,
    FINALRESULT         = NULL,
    FLOWCELLCOMMENTS    = NULL,
    FLOWCELLSTATUS      = 'BIP Uploading',  -- We introduce a new status to mark the BIP Uploading Job is in progress.
    GHFLOWCELLDESC      = NULL,
    MEANCLUSTERDENSITY  = NULL,
    MEANPFCLUSTERSDENSITY   = NULL,
    MODBY               = lower(user),
    MODDT               = sysdate,
    MODTOOL             = 'mulesoft_etl',
    NOTES               = NULL,
    PECENTAGEOFCLUSTERSPF   = NULL,
    PRODUCTTYPE         = NULL,
    QUALITYREAD01       = NULL,
    QUALITYREAD02       = NULL,
    QUALITYREAD03       = NULL,
    READPHASING01       = NULL,
    READPHASING02       = NULL,
    READPHASING03       = NULL,
    READPREPHASING01    = NULL,
    READPREPHASING02    = NULL,
    READPREPHASING03    = NULL,
    RUNID               = '<runid>',
    SAMPLESHEETCREATEDT = NULL,
    SECURITYDEPARTMENT  = NULL,
    SECURITYUSER        = user,
    SEQQCSTATUS         = NULL,
    SEQUENCERTYPE       = '<sequencer_type>',
    SUGGESTEDRESULT     = NULL,
    TEMPLATEFLAG        = 'N',
    TOTALCLUSTERS       = NULL,
    TOTALPFCLUSTERS     = NULL,
    TRACELOGID          = NULL,
    USERSEQUENCE        = NULL
WHERE U_GHFLOWCELLID = '<flowcellid>';

