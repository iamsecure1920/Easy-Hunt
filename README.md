# Easy-Hunt

Easy-Hunt is a Bash script designed to automate the reconnaissance process in bug bounty hunting. This script simplifies the setup and execution of recon tasks, providing an efficient way to gather information about a target.

## Features

- Subdomain enumeration
- Live host checking
- Endpoint collection
- Sensitive URL filtering
- XSS vulnerability filtering and scanning
- JavaScript file analysis
- Nuclei vulnerability scanning
- Nmap scanning
- AI-based summary of findings (using OpenAI)

## Prerequisites

Before running the Easy-Hunt script, ensure you have the following prerequisites installed:

- Go language
- jq (for JSON processing)
- Necessary tools (installed via `./Easy-Hunt.sh --install`)
- Else you can following commands to install uddup & jq
  ```bash
  pip install  uddup
  apt install jq
  ```

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/iamsecure1920/Easy-Hunt
   cd Easy-Hunt
   ```

2. **Install Go language:**

   To install Go, run the provided script:

   ```bash
   chmod +x ./Golang.sh
   ./Golang.sh
   source /root/.profile
   ```

3. **Install required tools:**

   Run the following command to install all necessary tools:

   ```bash
   chmod +x ./Easy-Hunt.sh
   ./Easy-Hunt.sh --install
   ```

## Usage

To run Easy-Hunt against a target, use the following command:

```bash
./Easy-Hunt.sh <target.com>
```

Replace `<target.com>` with the actual domain you want to target.

## Script Details

### Easy-Hunt.sh

The main script to automate the recon process. This script performs various reconnaissance tasks including subdomain enumeration, vulnerability scanning, and more.

#### Functions

- **install_tools:** Installs all required tools using Go.
- **query_openai:** Sends a prompt to the OpenAI API and retrieves a response.
- **subdomain_enumeration:** Enumerates subdomains and checks for live hosts.
- **endpoint_collection:** Collects endpoints and filters sensitive URLs.
- **filter_xss_vulnerable_urls:** Filters XSS vulnerable URLs.
- **scan_with_dalfox:** Scans for XSS vulnerabilities using Dalfox.
- **js_analysis:** Analyzes JavaScript files for vulnerabilities.
- **nuclei_scan:** Performs a vulnerability scan using Nuclei.
- **nmap_scan:** Conducts an Nmap scan for detailed information.
- **main:** The main function that orchestrates the recon process.

### Golang.sh

This script installs the Go programming language, which is a prerequisite for running Easy-Hunt.

## Contributing

If you'd like to contribute to this project, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For any questions or suggestions, feel free to open an issue or contact the repository owner.

---

### Example Commands

1. **Installing required tools:**

   ```bash
   ./Easy-Hunt.sh --install
   ```

2. **Running recon on a target:**

   ```bash
   ./Easy-Hunt.sh example.com
   ```


