-- Retrieve data from GHDB.sample_qc
-- Required parameters:
--      <flowcellID> - Parameter sent from LIMS BIP Upload module through messaging queue.
-- 
SELECT run_sample_id,
       runid,
       category,
       metric,
       verbose_name,
       unit,
       value,
       operator,
       threshold,
       status
FROM sample_qc where runid like '%<flowcellID>%';