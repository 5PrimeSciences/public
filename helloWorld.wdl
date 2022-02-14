workflow myWorkflow {
    call helloWorld
}

task helloWorld {
  # Make this pull something from a private repo
  # Actually, with how subworkflows work, we might just be able to say "this
  # entire workflow just looks here and runs this other workflow (which is not
  # public)" and give the inputs and outputs, in which case literally
  # everything else is a black box.
    command {
        echo "hello wdl"
    }
    output {
        String out = read_string(stdout())
    }
}
