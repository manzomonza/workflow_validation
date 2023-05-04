library(NGSannotation)
snv = bimiMatchUp(snv)
snv = clinvarTableOutput(snv)
snv = diagnose_D_F_columns_snv(snv)

# TSG annotation
snv_filepath = paste0(dir_path, "/prep_snv.txt")

snv_tsg = tsgParseTable(readr::read_tsv(snv_filepath))
snv_tsg = snv_tsg %>% dplyr::select(gene, coding, tsgInfo)
print('tsg')
print(snv_tsg)

# COSMIC COUNTER
snv_cosmic = cosmic_counter_wrapper(readr::read_tsv(snv_filepath))
snv_cosmic = snv_cosmic %>% dplyr::select(gene, coding, contains("COSMIC"))
print('snv_cosmic')
print(snv_cosmic)
# CANCER HOTSPOTS
snv_cancerHotspot = wrapper_table_cancerHotspots(readr::read_tsv(snv_filepath))
snv_cancerHotspot = snv_cancerHotspot %>% dplyr::select(gene, coding, cancerHotspot)

print('snv_cancerHotspot')
print(snv_cancerHotspot)

# GENE COLUMN NAME PROBLEM
if(!'gene' %in% colnames(snv) & 'genes' %in% colnames(snv)){
  snv$gene = snv$genes
}

#Join TSG
snv = dplyr::left_join(snv, snv_tsg, by = c("gene", 'coding'))

print('snv_cosmic')
#Join cosmic
snv = dplyr::left_join(snv, snv_cosmic, by = c("gene", 'coding'))

print('snv_cancerHotspot')
#Join cancerhotspot
snv = dplyr::left_join(snv, snv_cancerHotspot, by = c("gene", 'coding'))
}
