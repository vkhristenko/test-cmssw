import os, sys, glob

CN = 0
ESB = 1
DAM = 2
clusterNames = ["CN", "ESB", "DAM"]

def getJobId(path):
    return path.split('/')[-1][4:]

def parse(path):
    try:
        contents = glob.glob(os.path.join(path, "*"))
        if len(contents)<2: raise NameError("No valid results")
        for content in contents:
            if content.split("/")[-1] == "results.log":
                with open(content, 'r') as f:
                    lines = f.readlines()
                    #print(lines[-2], lines[-1])
                    return lines[-2]
        raise NameError("No valid results")
    except:
        print("Dir %s does not contain valid results" % path)

    return None

def print_stats(jobId, dataByType):
    # accumulate per type
    totals = []
    print("--- summary by node ---")
    for data in dataByType:
        totalThroughput = 0
        num = 0
        for d in data:
            if d[1] is not None:
                value = float(d[1].strip().split(" ")[0])
                #value = float(d[1][:-46].strip())
                totalThroughput += value
                num += 1
                print("{:>10} {:>5} evs/s".format(d[0], value))
        totals.append((num, totalThroughput))
    print("--- end of summary by node ---")
    print("--- job %d summary ---" % jobId)
    for i in range(len(totals)):
        print("{:>3}: {:>2} {} evs/s".format(
            clusterNames[i], totals[i][0], totals[i][1]))
    print("--- end of job %d summary ---" % jobId)

def arrangeByType(path):
    dirs = glob.glob(os.path.join(path, "*"))
    cn_nodes = []; esb_nodes = []; dam_nodes = [];
    for d in dirs:
        nodename = d.split("/")[-1]
        if nodename[0:6] == 'dp-esb':
            data = parse(d)
            esb_nodes.append((nodename, data))
        elif nodename[0:5] == 'dp-cn':
            data = parse(d)
            cn_nodes.append((nodename, data))
        elif nodename[0:6] == 'dp-dam':
            data = parse(d)
            dam_nodes.append((nodename, data))
        else:
            raise NameError("Unknown Node type: %s" % nodename)
    return (cn_nodes, esb_nodes, dam_nodes)

def main():
    # accomodate the input
    if len(sys.argv)<2:
        print(sys.argv)
        print("Wrong cli args. Exiting...")
        exit(1)

    try:
        # this is where all the logs per node are
        pathToLogs = sys.argv[1]
        jobId = int(getJobId(pathToLogs))
        dataByType = arrangeByType(pathToLogs)
        print_stats(jobId, dataByType)
    except NameError as err:
        print("Exception caught")
        print(err)
    except Exception as exc:
        print("Exception caught")
        print(exc)

if __name__ == "__main__":
    main()
