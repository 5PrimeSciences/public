version 1.1

workflow HelloWorld_WF{
	call HelloWorld{}
}

task HelloWorld {
	input {
		String prompt
		String docker_location
	}

	command <<<
		Rscript -e "print(\"~{prompt}\")"
	>>>

	output {
		String out=read_string(stdout())
	}

	runtime {
		docker: docker_location
		memory: "2GB"
		disks: "local-disk 20 HDD"
	}
}
