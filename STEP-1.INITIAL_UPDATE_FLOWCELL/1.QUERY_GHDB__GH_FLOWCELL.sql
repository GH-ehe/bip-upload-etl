-- Query on GHDB.gh_flowcell
-- <flowcellid> - The parameter we received from the LIMS system through messaging queue
SELECT
       runid,
       sequencer_type,
       bip_version,
       comment,
       array_to_string(ARRAY(select jsonb_extract_path_text(t.v, 'bolt_on_name')
                   || ' ' || jsonb_extract_path_text(t.v, 'version')
        from jsonb_each(comment->'bolt_ons') as t(k,v)), '|') as boltonversion
FROM gh_flowcell 
WHERE runId like '%<flowcellid>';

