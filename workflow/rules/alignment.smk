"""
Script builds reference database and mapping reads with Bowtie2
""" 

rule bowtie_database:
            input:
                config["dir_ref"] + config["name_ref"] + config["ext"]["ref"]
            
            params:  
                base= config["dir_ref"] + "reference"
            
            output:
                touch("index.done")
            
            threads: config["threads"]
            
            message: "Building reference database"
            
            log:
              "logs/bowtie/index.log"
            
            shell:
                "bowtie2-build -f {input} {params.base} 2> {log}"



rule bowtie_mapping:
              input:
                  trim="Trimmed_reads/{sample}_trimmed.fastq.gz",
                  check="index.done"
                  
              params:
                    base= config["dir_ref"] + "reference",
                    mode= config["bowtiemode"]
              
              output:
                    "Aligned/{sample}_mapping.sam"
                    
              threads: config["threads"]    
               
              message: "Started read mapping"
              
              log: "logs/bowtie/{sample}_mapping.log"     
              
              shell:
                  "bowtie2 -q -U {input.trim} -x {params.base} -S {output} {params.mode} 2> {log}"
                  
                  
                  
