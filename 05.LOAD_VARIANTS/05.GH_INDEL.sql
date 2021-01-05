SELECT DISTINCT
    ic.run_sample_id        AS SAMPLEID,
    ic.runid                AS RUNID,
    ic.gene                 AS GENE,
    ic.chrom                AS CHROMOSOME,
    ic.position             AS POSITION_START,
    ic.mut_nt               AS MUT_NT,
    ic.mut_aa               AS MUT_AA_SHORT,
    ic.length               AS LENGTH,
    ic.exon                 AS EXON,
    ic.type                 AS TYPE,
    ic.percentage           AS PERCENTAGE,
    ic.total_read_cnt       AS TOTAL_READ_CNT,
    ic.fam_cnt              AS FAM_CNT,
    ic.indel_fam_cnt        AS INDEL_FAM_CNT,
    ic.indel_ds_cnt         AS INDEL_DS_CNT,
    ic.tb_code              AS TBCODE,
    ic.call                 AS INDELCALL,
    ic.variant_comment      AS VARIANTCOMMENT,
    ic.analysis_version     AS ANALYSISVERSION,
    ic.transcript_id        AS TRANSCRIPT_ID,
    ic.splice_effect        AS SPLICEEFFECT,
    ic.cdna                 AS CDNA,
    ic.llscore              AS LLSCORE,
    ghv.cosmic_id           AS COSMIC_ID,
    ghv.dbsnp_id            AS DBSNP_ID,
    ic.reporting_category   AS REPORTING_CATEGORY
FROM indel_call ic LEFT JOIN gh_variant ghv
    ON ic.runid = ghv.runid AND ic.run_sample_id = ghv.run_sample_id
    AND ic.chrom = ghv.chrom AND ic.position = ghv.pos
    AND ic.cdna = ghv.cdna_change
WHERE
    ic.runid='<runid>' AND ic.run_sample_id='<run_sample_id>';


-- DELETE Existing records from u_ghindel
DELETE * FROM U_GHINDEL WHERE runid='<runid>' and sampleid='<sampleid>';

INSERT INTO U_GHINDEL (
    U_GHINDELID,
    SAMPLEID,
    RUNID,
    GENE,
    CHROMOSOME,
    POSITION_START,
    MUT_NT,
    MUT_AA_SHORT,
    LENGTH,
    EXON,
    TYPE,
    PERCENTAGE,
    TOTAL_READ_CNT,
    FAM_CNT,
    INDEL_FAM_CNT,
    INDEL_DS_CNT,
    TBCODE,
    INDELCALL,
    VARIANTCOMMENT,
    ANALYSISVERSION,
    TRANSCRIPT_ID,
    SPLICEEFFECT,
    CDNA,
    LLSCORE,
    COSMIC_ID,
    DBSNP_ID,
    REPORTING_CATEGORY
) VALUES (
    (SELECT MAX(TO_NUMBER(U_GHINDELID)) + 1 FROM U_GHINDEL),
    <SAMPLEID>,
    <RUNID>,
    <GENE>,
    <CHROMOSOME>,
    <POSITION_START>,
    <MUT_NT>,
    <MUT_AA_SHORT>,
    <LENGTH>,
    <EXON>,
    <TYPE>,
    <PERCENTAGE>,
    <TOTAL_READ_CNT>,
    <FAM_CNT>,
    <INDEL_FAM_CNT>,
    <INDEL_DS_CNT>,
    <TBCODE>,
    <INDELCALL>,
    <VARIANTCOMMENT>,
    <ANALYSISVERSION>,
    <TRANSCRIPT_ID>,
    <SPLICEEFFECT>,
    <CDNA>,
    <LLSCORE>,
    <COSMIC_ID>,
    <DBSNP_ID>,
    <REPORTING_CATEGORY>
);



