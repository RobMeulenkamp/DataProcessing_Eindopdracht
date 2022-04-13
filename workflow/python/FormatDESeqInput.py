#!/usr/bin/env python3


import sys

sys.stderr = open(snakemake.log[0], 'w')

def Read_coverage(infile):
    try:
        temp_dic = {}
        with open(infile) as temp:
            for i in temp:
                j = i.split('\t')
                temp_dic[j[8]] = j[9]

    except FileNotFoundError:
        print ('No such file or directory: '+infile)
        sys.exit(2)

    return temp_dic                


def Write_coverage(outfile, coverages, order):
    CDSs = list(coverages[order[0]].keys())
    CDSs.sort()
    try:
        with open(outfile, 'w') as temp:
            temp.write('\t'.join(['GI', ]+[i.split('/')[-1][:-4] for i in order]))
            temp.write('\n')
            for CDS in CDSs:
                temp.write(CDS)
                for sample in order:
                    temp.write('\t'+coverages[sample][CDS])
                temp.write('\n')
                
    except FileNotFoundError:
        print ('No such file or directory: '+outfile)
        sys.exit(2)

    return False
    
def main():    
    #Arguments from snakemake
    snake_input = snakemake.input
    snake_output = snakemake.output[0]
        
    coverages = {}
    for sample in snake_input:
        coverages[sample] = Read_coverage(sample)
        
    Write_coverage(snake_output, coverages, snake_input)
    
    return 0

if __name__ == '__main__':
    sys.exit(main())