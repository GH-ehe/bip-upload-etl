-- Query GH_BOARD data from GHDB
SELECT  
    DISTINCT                    -- This is a question we should ask GHDB team why for a single runid + run_sample_id there are duplicated records
    run_sample_id        AS sampleid
    ,runid               AS runid                
    ,snv_call            AS snvcall             
    ,snv_comment         AS snvcomment             
    ,snv_positive        AS snvpositivecnt            
    ,cnv_call            AS cnvcall                     
    ,cnv_comment         AS cnvcomment      
    ,cnv_positive        AS cnvpositivecnt     
    ,indel_call          AS indelcall       
    ,indel_comment       AS indelcomment    
    ,indel_positive      AS indelpositivecnt   
    ,fusion_call         AS fusioncall      
    ,fusion_comment      AS fusioncomment   
    ,fusion_positive     AS fusionpositivecnt  
    ,report_type         AS reporttype          -- The value of this column is only needed for BIP Version 2.2
    ,analysis_version    AS analysisversion
    ,run_sample_id       AS ghboarddesc         -- Use sampleid for ghboarddesc field 
FROM gh_board;


-- Assumption: All data belongs to the runid + sampleid combination should have been deleted before the insert
DELETE * FROM u_ghboard WHERE runid='<runid>' and sampleid='<sampleid>';

-- INSERT INTO LIMS u_ghboard table
INSERT INTO u_ghboard (
    u_ghboardid
    ,sampleid
    ,runid             
    ,snvcall           
    ,snvcomment        
    ,snvpositivecnt       
    ,cnvcall           
    ,cnvcomment      
    ,cnvpositivecnt     
    ,indelcall       
    ,indelcomment    
    ,indelpositivecnt   
    ,fusioncall      
    ,fusioncomment   
    ,fusionpositivecnt  
    ,reporttype        
    ,analysisversion
    ,ghboarddesc       
) VALUES (
    (SELECT MAX(TO_NUMBER(u_ghboardid)) + 1 FROM u_ghboard)     -- We have to use this ID generation method at this moment. It should be an Auto Increment PK.
    ,<sampleid>
    ,<runid>          
    ,<snvcall>        
    ,<snvcomment>     
    ,<snvpositivecnt>    
    ,<cnvcall>   
    ,<cnvcomment>     
    ,<cnvpositivecnt>    
    ,<indelcall>
    ,<indelcomment>   
    ,<indelpositive>  
    ,<fusioncall>
    ,<fusioncomment>
    ,<fusionpositive> 
    ,<reporttype>
    ,<analysisversion>
    ,<ghboarddesc>
)