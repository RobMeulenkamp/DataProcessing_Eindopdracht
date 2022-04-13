"""
R script creates two visualizations, but first installing the needed packages.
""" 

rule install_packages:
          input:
              "index.done"
          
          output:
                touch("install.done")
              
          message: "Started with installing the necessary packages"
          
          threads: config["threads"]
          
          shell:
              "Rscript workflow/R/InstallPackages.R"

rule visual:
          input:
              deseq = "Differential_expression/DESeq_Input.txt",
              design = config["dir_ref"] + "Design_sheet.txt",
              check = "install.done"
              
          params:
              "images/"
              
          output:
              "images/PCA.pdf",
              "images/Dendrogram_and_heatmap.pdf"
              
          threads: config["threads"]
              
          message: "Started with creating the visualizations"
              
          log: 
            "logs/R/image.log"
            
          shell:
              "Rscript workflow/R/RunDESeq.R {input.deseq} {input.design} {params} {log}"