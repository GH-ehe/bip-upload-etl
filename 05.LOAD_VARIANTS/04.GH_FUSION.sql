-- Note: 
--  This is a specific query for Base bip upload. There are different queries for different bip versions, 
--  there should be a few more specific queries identified for those bip versions.
--  
SELECT
    DISTINCT
    gf.orientation_gene_a          AS ORIENTATION_GENE_A,
    gf.orientation_gene_b          AS ORIENTATION_GENE_B,
    gf.direction_a                 AS DIRECTION_A,
    gf.direction_b                 AS DIRECTION_B,
	gf.fusion_candidate_index      AS FUSION_CANDIDATE_INDEX,
	gf.percent_fusion_ab           AS PERCENT_FUSION_AB,
	gf.percent_fusion_a            AS PERCENT_FUSION_A,
	gf.percent_fusion_b            AS PERCENT_FUSION_B,
	gf.fusion_read_count_ab        AS FUSION_READ_COUNT_AB,
	gf.fusion_read_count_a         AS FUSION_READ_COUNT_A,
	gf.fusion_read_count_b         AS FUSION_READ_COUNT_B,
	gf.wildtype_read_count_a       AS WILDTYPE_READ_COUNT_A,
	gf.wildtype_read_count_b       AS WILDTYPE_READ_COUNT_B,
    gf.cluster_width_a             AS CLUSTER_WIDTH_A,
	gf.cluster_width_b             AS CLUSTER_WIDTH_B,
    fc.gene_a                      AS GENE_A,
	fc.gene_b                      AS GENE_B,
	fc.fusion_molecule_count_ab    AS FUSION_MOLECULE_COUNT_AB,
	fc.fusion_molecule_count_a     AS FUSION_MOLECULE_COUNT_A,
	fc.fusion_molecule_count_b     AS FUSION_MOLECULE_COUNT_B,
	fc.chrom_a                     AS CHROMOSOME_A,
	fc.chrom_b                     AS CHROMOSOME_B,
	fc.pos_a                       AS POSITION_A,
	fc.pos_b                       AS POSITION_B,
    fc.analysis_version            AS ANALYSISVERSION,
	fc.nof1_comment                AS NOF1_COMMENT,
    fc.Molecule_Coverage_A         AS WILDTYPE_MOLECULE_COUNT_A,
    fc.Molecule_Coverage_B         AS WILDTYPE_MOLECULE_COUNT_B,
    fc.downstream_gene             AS DOWNSTREAM_GENE,
    fc.tb_code                     AS TBCODE,
    fc.call                        AS FUSION_CALL,
    fc.variant_comment             AS VARIANTCOMMENT,
	fc.run_sample_id               AS SAMPLEID,
	fc.runid                       AS RUNID
FROM fusion_call fc LEFT JOIN gh_fusion gf 
    ON fc.runid = gf.runid 
    AND fc.run_sample_id = gf.run_sample_id
    AND fc.chrom_a  = gf.chromosome_a 
    AND fc.chrom_b = gf.chromosome_b
    AND fc.pos_a = gf.position_a 
    AND fc.pos_b =gf.position_b
WHERE fc.runid='<runid>' AND fc.run_sample_id='<sampleId>';

-- DELETE Existing records from u_ghfusion
DELETE * FROM U_GHFUSION WHERE runid='<runid>' and sampleid='<sampleid>';

INSERT INTO U_GHFUSION (
    U_GHFUSIONID,
    ORIENTATION_GENE_A,
    ORIENTATION_GENE_B,
    DIRECTION_A,
    DIRECTION_B,
    FUSION_CANDIDATE_INDEX,
    PERCENT_FUSION_AB,
    PERCENT_FUSION_A,
    PERCENT_FUSION_B,
    FUSION_READ_COUNT_AB,
    FUSION_READ_COUNT_A,
    FUSION_READ_COUNT_B,
    WILDTYPE_READ_COUNT_A,
    WILDTYPE_READ_COUNT_B,
    CLUSTER_WIDTH_A,
    CLUSTER_WIDTH_B,
    GENE_A,
    GENE_B,
    FUSION_MOLECULE_COUNT_AB,
    FUSION_MOLECULE_COUNT_A,
    FUSION_MOLECULE_COUNT_B,
    CHROMOSOME_A,
    CHROMOSOME_B,
    POSITION_A,
    POSITION_B,
    ANALYSISVERSION,
    NOF1_COMMENT,
    WILDTYPE_MOLECULE_COUNT_A,
    WILDTYPE_MOLECULE_COUNT_B,
    DOWNSTREAM_GENE,
    TBCODE,
    FUSION_CALL,
    VARIANTCOMMENT,
    SAMPLEID,
    RUNID
) VALUES (
    (SELECT MAX(TO_NUMBER(U_GHFUSIONID)) + 1 FROM U_GHFUSION),
    <ORIENTATION_GENE_A>,
    <ORIENTATION_GENE_B>,
    <DIRECTION_A>,
    <DIRECTION_B>,
    <FUSION_CANDIDATE_INDEX>,
    <PERCENT_FUSION_AB>,
    <PERCENT_FUSION_A>,
    <PERCENT_FUSION_B>,
    <FUSION_READ_COUNT_AB>,
    <FUSION_READ_COUNT_A>,
    <FUSION_READ_COUNT_B>,
    <WILDTYPE_READ_COUNT_A>,
    <WILDTYPE_READ_COUNT_B>,
    <CLUSTER_WIDTH_A>,
    <CLUSTER_WIDTH_B>,
    <GENE_A>,
    <GENE_B>,
    <FUSION_MOLECULE_COUNT_AB>,
    <FUSION_MOLECULE_COUNT_A>,
    <FUSION_MOLECULE_COUNT_B>,
    <CHROMOSOME_A>,
    <CHROMOSOME_B>,
    <POSITION_A>,
    <POSITION_B>,
    <ANALYSISVERSION>,
    <NOF1_COMMENT>,
    <WILDTYPE_MOLECULE_COUNT_A>,
    <WILDTYPE_MOLECULE_COUNT_B>,
    <DOWNSTREAM_GENE>,
    <TBCODE>,
    <FUSION_CALL>,
    <VARIANTCOMMENT>,
    <SAMPLEID>,
    <RUNID>
);









