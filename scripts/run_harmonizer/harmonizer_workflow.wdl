version 1.0

# Copyright 2022 5 Prime Sciences, Inc. All Rights Reserved.
# Workflow to run the harmonizer

task run_harmonizer {

  input {
    File harmonizer_rscript
    File raw_json
    File raw_data
    File rsid_path
    File dbsnp_vcf
    File dbsnp_vcf_tbi
  }

  command <<<
    ln -s ~{raw_data}
    Rscript --vanilla ~{harmonizer_rscript} ~{raw_json} ~{rsid_path} ~{dbsnp_vcf}
  >>>

  output {
    File dump_dbsnps = "h_dump_dbsnps.qs"
    File error_summary = "h_error_summary.json"
    File h_file = "chunks_all_h.txt"
  }
  
  runtime {
    cpu:32
    bootDiskSizeGb: 250
    disks: "local-disk 500 SSD"
    memory: "64G"
    docker: "gcr.io/primesciences-storage/base-analytics:latest"
  }

}

workflow run_harmonizer {

  input {
    File harmonizer_rscript
    File raw_json
    File raw_data
    File rsid_path
    File dbsnp_vcf
    File dbsnp_vcf_tbi
  }

  call run_harmonizer {
    input:
      harmonizer_rscript = harmonizer_rscript,
      raw_json = raw_json,
      raw_data = raw_data,
      rsid_path = rsid_path,
      dbsnp_vcf = dbsnp_vcf,
      dbsnp_vcf_tbi = dbsnp_vcf_tbi
  }

  output {
    File dump_dbsnps = run_harmonizer.dump_dbsnps
    File error_summary = run_harmonizer.error_summary
    File h_file = run_harmonizer.h_file
  }

}
