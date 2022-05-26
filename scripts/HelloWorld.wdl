version 1.0

task HelloWorld {
	input {
		String prompt
	}
	
	command <<<
		echo ~{prompt}
	>>>
	output {
	    String out=read_string(stdout())
	}

	runtime {
		docker: "python:latest"
		memory: "2GB"
		disks: "local-disk 20 HDD"
	}
}

workflow HelloWorld_WF{
	call HelloWorld{}
}


