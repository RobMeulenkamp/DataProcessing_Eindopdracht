"""
Script decompiles the mapping data
""" 

rule samtools_view:
              input:
                  "Aligned/{sample}_mapping.sam"
              
              output:
                  "Decompiled/{sample}_mapping.bam"
              
              message: "Started with decompiling the mapping data"
              
              log: "logs/Decompiled/{sample}_mapping.log"

              shell:
                  "samtools view -bS {input} > {output} 2> {log}"


rule samtools_sort:
                input:
                    "Decompiled/{sample}_mapping.bam"
                    
                output:
                    "Sorted_reads/{sample}_mapping.bam"
              
                message: "Started with sorting the bam files"
              
                log: "logs/Sorted_reads/{sample}_mapping.log"
                
                shell:
                    "samtools sort -T sorted_reads/{wildcards.sample} "
                    "-O bam {input} > {output} 2> {log}"


rule bedtools_bamtobed:
                    input:
                        "Sorted_reads/{sample}_mapping.bam"
                        
                    output:
                        "Decompiled/{sample}.bed" 
                        
                    message: "Started with converting bam file to a bed file"
              
                    log: "logs/bedtools/{sample}.log"
                    
                    shell:
                        "bedtools bamtobed -i {input} > {output} 2> {log}"
