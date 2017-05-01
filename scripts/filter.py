import sys
inFile = sys.argv[1]    #chip peaks
inFile2 = sys.argv[2]   #dnase peaks
outFile = sys.argv[3]   #filtered chip peaks


def main():
    chip_count = open(inFile, 'r').read().count("\n") 
    dnase_count = open(inFile2, 'r').read().count("\n") 


    with open(inFile) as chip:
            chip_col = zip(*(line.strip().split('\t') for line in chip))

    chip_reading = open(inFile, 'r')
    chip_writing = open(outFile, 'a')

    with open(inFile2) as dnase:
            dnase_col= zip(*(line.strip().split('\t') for line in dnase))

    #print chip_col[1][0]
    for i in range(0, chip_count,1):
            temp = chip_reading.readline()
            for j in range(0, dnase_count, 1): 
                    if ((chip_col[1][i] >= dnase_col[1][j]) and (chip_col[2][i] <= dnase_col[2][j])): 
                           chip_writing.write(temp)
                           break



main()

