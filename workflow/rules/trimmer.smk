"""
Trimmomatic trims low quality reads and adapter sequence 
""" 



rule trimmomatic:
     input:
         raw="raw_reads/{sample}" + config["ext"]["raw"],
         anno=config["trimmomatic"]["adapter"]
         
     output:
         "Trimmed_reads/{sample}_trimmed.fastq.gz"  
         
     threads: config["threads"]
     
     params:
           jar = config["trimmomatic"]["jar"],
           phred = config["trimmomatic"]["phred"],
           minlen = config["trimmomatic"]["minlen"],
           maxmismatch = config["trimmomatic"]["maxmismatch"],
           pairend = config["trimmomatic"]["pairend"],
           minscore = config["trimmomatic"]["minscore"],
           slidwindow = config["trimmomatic"]["slidwindow"],
           minqual = config["trimmomatic"]["minqual"]
      
     message: "Started read trimming!"
     
     log:
       "logs/trimmomatic/{sample}_trimmed.log"
     
     
     shell:
         "java -jar {params.jar} \
         SE {params.phred} {input.raw} {output} \
         ILLUMINACLIP:{input.anno}:{params.maxmismatch}:{params.pairend}:{params.minscore} \
         SLIDINGWINDOW:{params.slidwindow}:{params.minqual} \
         MINLEN:{params.minlen} -threads {threads} 2> {log}"