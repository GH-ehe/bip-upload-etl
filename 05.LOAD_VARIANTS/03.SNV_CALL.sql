-- Query SNV_CALL data from GHDB
SELECT 
    DISTINCT    
    run_sample_id          AS sampleid
    ,runid                 AS runid
    ,gene                  AS gene
    ,chrom                 AS chromosome
    ,position              AS position    
    ,mut_nt                AS mutation_nt
    ,mut_aa                AS mutation_aa
    ,percentage            AS percentage    
    ,mol_cnt               AS mol_cnt
    ,zscore                AS zscore
    ,tier                  AS tier
    ,cosmic                AS cosmic_id
    ,dbsnp                 AS dbsnp_id
    ,tb_code               AS tbcode
    ,call                  AS snvcall
    ,variant_comment       AS variantcomment
    ,analysis_version      AS analysisversion
    ,cdna                  AS cdna
    ,splice_effect         AS spliceeffect
    ,transcript_id         AS transcript_id
    ,exon                  AS exon                   -- V30
    ,reporting_category    AS reporting_category     -- V30
    ,somatic_call          AS somatic_call           -- V33, OmniV10
    ,somatic_score         AS somatic_score          -- V33, OmniV10
    ,somatic_review        AS somatic_review         -- LunarV38, OmniV10
    ,tumor_call            AS tumorcall              -- LunarV38
    ,ldt_reportable        AS ldtreportable          -- LunarV38         
    ,clinvar_id            AS clinvar_id             -- Omni391
    ,clinvar_clinsig       AS clinvar_clinsig        -- Omni391
    ,molecular_consequence AS molecular_consequence  -- Omni391
    ,functional_impact     AS functional_impact      -- Omni391
    ,mutant_allele_status  AS mutant_allele_status   -- Omni391
FROM snv_call 
WHERE runid = '<runid>' AND run_sample_id = '<sampleid>'

-- DELETE Existing records from u_ghsnv
DELETE * FROM u_ghsnv WHERE runid='<runid>' and sampleid='<sampleid>';


-- INSERT into u_ghsnv
INSERT INTO u_ghsnv (
    U_GHSNVID 
    ,SAMPLEID
    ,RUNID
    ,GENE
    ,CHROMOSOME
    ,POSITION    
    ,MUTATION_NT
    ,MUTATION_AA
    ,PERCENTAGE    
    ,MOL_CNT
    ,ZSCORE
    ,TIER
    ,COSMIC_ID
    ,DBSNP_ID
    ,TBCODE
    ,SNVCALL
    ,VARIANTCOMMENT
    ,ANALYSISVERSION
    ,CDNA
    ,SPLICEEFFECT
    ,TRANSCRIPT_ID
    ,EXON                 
    ,REPORTING_CATEGORY   
    ,SOMATIC_CALL         
    ,SOMATIC_SCORE        
    ,SOMATIC_REVIEW       
    ,TUMORCALL            
    ,LDTREPORTABLE        
    ,CLINVAR_ID           
    ,CLINVAR_CLINSIG      
    ,MOLECULAR_CONSEQUENCE
    ,FUNCTIONAL_IMPACT    
    ,MUTANT_ALLELE_STATUS 
) VALUES ( 
    (SELECT MAX(TO_NUMBER(U_GHSNVID)) + 1 FROM u_ghsnv)
    ,<sampleid>
    ,<runid>
    ,<gene>
    ,<chromosome>
    ,<position>
    ,<mutation_nt>
    ,<mutation_aa>
    ,<percentage>
    ,<mol_cnt>
    ,<zscore>
    ,<tier>
    ,<cosmic_id>
    ,<dbsnp_id>
    ,<tbcode>
    ,<snvcall>
    ,<variantcomment>
    ,<analysisversion>
    ,<cdna>
    ,<spliceeffect>
    ,<transcript_id>
    ,<exon>                 
    ,<reporting_category>
    ,<somatic_call>      
    ,<somatic_score>     
    ,<somatic_review>       
    ,<tumorcall>      
    ,<ldtreportable>        
    ,<clinvar_id>       
    ,<clinvar_clinsig>      
    ,<molecular_consequence>
    ,<functional_impact>    
    ,<mutant_allele_status> 
)

























