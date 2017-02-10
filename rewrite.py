import csv

with open('lel.txt','r') as file:
    for line in file:
        ips = line.split(",")
        with open('unreachables.csv','w',newline='') as unreachables:
            writer = csv.writer(unreachables)
            for ip in ips:
                ip = ip.strip("\'").strip()
                writer.writerow([ip, 0, 0, -1])
