version 1.0

task RunHarmonizer {
	input {
		File harmonizer_rscript
		File raw_json
		File raw_data
		File rsid_path
		File dbsnp_vcf
		File dbsnp_vcf_tbi

		String? branch_name # branch in the harmonizer repo to use
	}
	
	command <<<

        set -euo pipefail
        
		# if branch is defined, git checkout that branch.
		#if [ "" != "~{select_first([branch_name,''])}" ]; then
		#	git checkout -b ~{branch_name}
		#fi
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
        docker: "northamerica-northeast1-docker.pkg.dev/general-345619/harmonizer-docker/harmonizer-rapid:1649259549"
        bootDiskSizeGb: 250
        disks: "local-disk 500 SSD"
        memory: "64G"
	}
}

workflow RunHarmonizerWF{
	call RunHarmonizer{}

    output {
           File dump_dbsnps = RunHarmonizer.dump_dbsnps
           File error_summary = RunHarmonizer.error_summary
           File h_file = RunHarmonizer.h_file
    }
}



