-- Query CNV_CALL data from GHDB

SELECT DISTINCT
    run_sample_id       AS sampleId,    
    ,runid              AS runid
    ,gene               AS gene
    ,chrom              AS chromosome           -- Chromosome on for V33, OmniV35, OmniV391 and onward
    ,copy_number        AS copynumber
    ,mean               AS mean   
    ,sd                 AS sd   
    ,zscore             AS zscore  
    ,p_value            AS pvalue   
    ,tb_code            AS tbcode   
    ,call               AS cnvcall   
    ,variant_comment    AS variantcomment       
    ,analysis_version   AS analysisversion           
    ,ldt_reportable     AS ldtreportable        -- LunarV38, OmniV391
FROM cnv_call


-- Assumption: All data belongs to the runid + sampleid combination should have been deleted before the insert
DELETE * FROM u_ghcnvgene WHERE runid='<runid>' and sampleid='<sampleid>';

-- INSERT INTO LIMS u_ghcnvgene table
INSERT INTO u_ghcnvgene (
    u_ghcnvgeneid
    ,sampleId    
    ,runid
    ,gene
    ,chromosome       
    ,copynumber
    ,mean   
    ,sd   
    ,zscore  
    ,pvalue   
    ,tbcode   
    ,cnvcall   
    ,variantcomment   
    ,analysisversion  
    ,ldtreportable    
) VALUES (
    (SELECT MAX(TO_NUMBER(u_ghcnvgeneid)) + 1 FROM u_ghcnvgene) 
    ,<sampleid>
    ,<runid>          
    ,<gene>
    ,<chromosome>       
    ,<copynumber>
    ,<mean>   
    ,<sd>   
    ,<zscore>  
    ,<pvalue>   
    ,<tbcode>   
    ,<cnvcall>   
    ,<variantcomment>   
    ,<analysisversion>  
    ,<ldtreportable>
)


