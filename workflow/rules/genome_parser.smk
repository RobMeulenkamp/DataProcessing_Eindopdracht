"""
Convert the information-rich GFF3 file into an essential GFF file 
""" 

rule parse_genome_annotation:
                      input:
                          config["dir_ref"] + config["name_ref"] + config["ext"]["anno"]
                          
                      output:
                          config["dir_ref"] + config["name_ref"] + config["ext"]["new_anno"]
                      
                      threads: config["threads"]
              
                      message: "Started with parsing genome annotation file"
                      
                      log: "logs/referenceDB/" + config["name_ref"] + "_CDS.log"
                          
                      script:
                          "../python/ParseGenomeAnnotation.py"
                          
                                     