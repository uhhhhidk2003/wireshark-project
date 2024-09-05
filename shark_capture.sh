#!/usr/bin/bash



#CHECKING FOR PCAP FILE
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_pcap_file>"
  exit 1
fi


cap_file=$1

if [ ! -f "$cap_file" ]; then
  echo "Error: File '$cap_file' not found!"
  exit 1
fi

analyze_traffic() {



 echo "Analyzing traffic from file: $cap_file"

    # total packets
    total_packets=$(tshark -r "$cap_file" | wc -l)

    #  HTTP packets
    http_packets=$(tshark -r "$cap_file" -Y "http" | wc -l)

    #  HTTPS packets (TLS)
    https_packets=$(tshark -r "$cap_file" -Y "tls" | wc -l)

    #  top 5 source IP addresses
    top_source_ips=$(tshark -r "$cap_file" -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5)

    #  top 5 destination IP addresses
    top_dest_ips=$(tshark -r "$cap_file" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5)



    echo "----- Network Traffic Analysis Report -----"

    echo "1. Total Packets: $total_packets"

    echo "2. Protocols:"

    echo "   - HTTP: $http_packets packets"

    echo "   - HTTPS/TLS: $https_packets packets"

    echo ""

    echo "3. Top 5 Source IP Addresses:"

    echo "$top_source_ips"

    echo ""

    echo "4. Top 5 Destination IP Addresses:"

    echo "$top_dest_ips"

    echo ""

    echo "----- End of Report -----"

































}
analyze_traffic
