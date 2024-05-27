#!/bin/bash

# Simple text banner
echo "========================================"
echo "    Easy Hunt  "
echo "  Automated Bug Hunting Tool with AI"
echo "      Developed by @iamsecure1920"
echo "             Team ICP           "
echo "========================================"

# Your OpenAI API key
API_KEY=" //YOUR OPENAI API KEY "

# Install required tools
install_tools() {
    echo "Installing required tools..."

    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest &&
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest &&
    go install -v github.com/tomnomnom/anew@latest &&
    go install github.com/hahwul/dalfox/v2@latest &&
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest &&
    go install github.com/lc/gau/v2/cmd/gau@latest &&
    go install github.com/tomnomnom/gf@latest &&
    go install github.com/tomnomnom/httprobe@latest &&
    go install github.com/projectdiscovery/katana/cmd/katana@latest &&
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest &&
    go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest &&
    go install github.com/tomnomnom/qsreplace@latest &&
    go install github.com/tomnomnom/unfurl@latest &&
    go install github.com/tomnomnom/waybackurls@latest &&
    go install github.com/MrEmpy/mantra@latest

    echo "[+] Tools Installed Successfully! [+]"
    
    # Navigate to the Go bin directory
    echo "// Navigating to Go bin directory... \\"
    cd "$(go env GOPATH)/bin" || exit

    # Copy the binaries to /usr/local/bin
    echo "[/] Copying binaries to /usr/local/bin... [\]"
    sudo cp anew dalfox dnsx gau gf httprobe httpx katana nuclei qsreplace shuffledns mantra subfinder unfurl waybackurls /usr/local/bin
}

# Function to send a prompt to OpenAI API and get a response
query_openai() {
    local prompt_text="$1"
    local response=$(curl -s -X POST "https://api.openai.com/v1/engines/text-davinci-003/completions" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -d "{\"prompt\": \"$prompt_text\", \"max_tokens\": 150}")

    echo "$response" | jq -r '.choices[0].text'
}

# Subdomain enumeration and live host check
subdomain_enumeration() {
    echo "[=>] Enumerating subdomains for $1..."
    subfinder -d "$1" | tee "$target_domain/subdomains.txt"
    httpx -l "$target_domain/subdomains.txt" | tee "$target_domain/livedomains.txt"
    sed 's/https:\/\///g;s/http:\/\///g' "$target_domain/livedomains.txt" | sort -u > "$target_domain/nmapsubdomains.txt"
}

# Endpoint collection and sensitive URL filtering
endpoint_collection() {
    echo "[++] Collecting endpoints..."
    cat "$target_domain/livedomains.txt" | waybackurls | tee "$target_domain/waybackurls.txt"
    cat "$target_domain/waybackurls.txt" | grep -E 'api|admin|vpn|auth|key|password|js|developer|token|json|dev|id=' | sort | tee "$target_domain/sensitiveurls.txt"
    uddup -u "$target_domain/waybackurls.txt" -s -o "$target_domain/uniquewaybackurls.txt" 
}

# Filter XSS vulnerable URLs
filter_xss_vulnerable_urls() {
    echo "Filtering XSS vulnerable URLs..."
    cat "$target_domain/uniquewaybackurls.txt" | gf xss >> "$target_domain/xss.txt"
    echo "XSS vulnerable URLs saved to $target_domain/xss.txt"
}

# Scan with Dalfox
scan_with_dalfox() {
    echo "[!!] Scanning XSS vulnerable URLs with Dalfox..."
    dalfox file "$target_domain/xss.txt" -o "$target_domain/Vul_xss.txt"
    echo "[^^] Dalfox scan results saved to $target_domain/Vul_xss.txt"
}

# JavaScript analysis
js_analysis() {
    echo "[<<] Analyzing JavaScript files..."
    cat "$target_domain/waybackurls.txt" | grep ".js$" | tee "$target_domain/js_urls.txt"
    cat "$target_domain/js_urls.txt" | mantra | tee "$target_domain/vul-js.txt"
    grep -v "Unable to make a request for" "$target_domain/vul-js.txt" > "$target_domain/mantraVuljs.txt"
    echo "[>>] Filtered URLs saved to $target_domain/mantraVuljs.txt"
}

# Nuclei vulnerability scan
nuclei_scan() {
    echo "[{}] Running Nuclei vulnerability scan..."
    nuclei -l "$target_domain/livedomains.txt" | tee "$target_domain/resultsofnuclei.txt"
}

# Nmap scan
nmap_scan() {
    echo "[||] Running Nmap scan..."
    nmap -sV --script=vuln -A -p- -iL "$target_domain/nmapsubdomains.txt"
}

# Main function
main() {
    if [ "$1" == "--install" ]; then
        install_tools
        exit 0
    elif [ -z "$1" ]; then
        echo "Usage: $0 [--install] <target_domain>"
        exit 1
    fi

    target_domain="$1"

    # Create a directory for the target domain
    mkdir -p "$target_domain"
    if [ ! -d "$target_domain" ]; then
        echo "Failed to create directory for target domain: $target_domain"
        exit 1
    fi

    # Remove existing files
    rm -f "$target_domain/subdomains.txt" "$target_domain/livedomains.txt" "$target_domain/nmapsubdomains.txt" "$target_domain/waybackurls.txt" "$target_domain/sensitiveurls.txt" "$target_domain/js_urls.txt" "$target_domain/vul-js.txt" "$target_domain/mantraVuljs.txt" "$target_domain/resultsofnuclei.txt" "$target_domain/xss.txt" "$target_domain/uniquewaybackurls.txt" 

    subdomain_enumeration "$target_domain"
    endpoint_collection
    filter_xss_vulnerable_urls
    scan_with_dalfox
    js_analysis
    nuclei_scan
    nmap_scan

    # AI integration to summarize findings
    echo "Generating AI-based summary of findings..."
    summary_prompt="Please summarize the security findings for $target_domain based on the scans conducted:"
    summary=$(query_openai "$summary_prompt")
    echo "AI Summary of Findings: $summary"

    echo "Penetration testing completed successfully!"
}

main "$@"

