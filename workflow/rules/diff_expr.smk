"""
Differential expression and reformat the file
""" 

SAMPLES = config["samples"]

rule bedtools_cov:
              input:
                  ref = config["dir_ref"] + config["name_ref"] + "_CDS.gff",
                  bed = "Decompiled/{sample}.bed"
                                  
              output:
                  "Differential_expression/{sample}.cov"
                  
              threads: config["threads"]
              
              message: "Started with differential expression"
              
              log: "logs/differential_expression/{sample}.log"   
                  
              shell:                          
                  "bedtools coverage -a {input.ref} -b {input.bed} -s > {output} 2> {log}"


rule format_DESeq:
              input:
                  expand("Differential_expression/{sample}.cov", sample=SAMPLES)
                  
              output:
                  "Differential_expression/DESeq_Input.txt"
              
              threads: config["threads"]
              
              message: "Started with formatting differential expression file"
              
              log: "logs/differential_expression/DESeq_Input.log" 
                    
              script:
                  "../python/FormatDESeqInput.py"