'''
Creates a dag file from steps from the pipeline.
'''

rule dag_file:
    output:
        "images/dag.png"
    message:
        "Creates a dag file from steps from the pipeline"
    shell:
         "snakemake --forceall --dag | dot -Tpng > images/dag.png"