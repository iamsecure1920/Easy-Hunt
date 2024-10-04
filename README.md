# Enhanced Easy Hunt

**Enhanced Easy Hunt** is a Bash script designed to automate the bug bounty hunting process. This advanced version integrates AI-enhanced analysis, offering a comprehensive suite of tools for efficient and thorough security assessments.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Example Commands](#example-commands)
- [License](#license)

## Features

Enhanced Easy Hunt offers the following features to assist in your bug bounty hunting efforts:
- **Subdomain Enumeration**: Collect subdomains to identify a broader attack surface.
- **Live Host Checking**: Detect which subdomains are live.
- **Endpoint Collection**: Gather endpoints from JavaScript files and web responses.
- **Sensitive URL Filtering**: Identify potential sensitive URLs that might expose vulnerabilities.
- **XSS Vulnerability Filtering and Scanning**: Filter out potential XSS endpoints and automatically scan for vulnerabilities.
- **JavaScript File Analysis**: Analyze JavaScript files for hidden endpoints and sensitive data.
- **Nuclei Vulnerability Scanning**: Use Nuclei templates to identify known vulnerabilities.
- **Nmap Scanning**: Perform network scanning using Nmap for open ports and services.
- **SQLi Vulnerability Detection**: Scan for SQL injection vulnerabilities.
- **SSRF Vulnerability Checking**: Detect potential Server-Side Request Forgery vulnerabilities.
- **AI-based Summary of Findings**: Utilize OpenAI's API to summarize findings in a concise report.
- **HTML Report Generation**: Create professional-looking HTML reports with all gathered data.
- **Aggressive Mode**: For intensive scanning with higher scrutiny.
- **Rate Limiting**: Ensure responsible scanning by limiting request rates to avoid overwhelming the target.

## Prerequisites

Before running the Enhanced Easy Hunt script, ensure you have the following tools and libraries installed on your system:

- **Go** (Golang)
- **jq** (for JSON processing)
- **Python** (required for `uddup` and other AI components)
- Necessary tools (install via the script)

To install `uddup` and `jq`, run the following commands:

```bash
pip install uddup
sudo apt install jq
```

## Installation

To set up Enhanced Easy Hunt, follow these steps:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/enhanced-easy-hunt.git
    cd enhanced-easy-hunt
    ```

2. **Install dependencies**:
    Run the following command to install all required tools and dependencies:
    ```bash
    ./easy_hunt.sh --install
    ```

3. **Configure API keys**:
    If you plan to use the AI-based summary, ensure that your OpenAI API key is configured. Export the API key as an environment variable:

    ```bash
    export OPENAI_API_KEY="your-openai-api-key"
    ```

## Usage

To run the Enhanced Easy Hunt script, execute the following command:

```bash
./easy_hunt.sh [options] <target>
```

Replace `<target>` with the target domain or IP address. Some useful options include:

- `--aggressive`: Enable aggressive mode for deeper scans.
- `--output <filename>`: Specify a custom output file for the generated report.
- `--nuclei`: Run Nuclei vulnerability scans.
- `--nmap`: Perform a network scan using Nmap.
- `--ai-summary`: Generate an AI-based summary of findings.

### Example Commands

- **Basic Subdomain Enumeration**:
    ```bash
    ./easy_hunt.sh example.com
    ```

- **Run in Aggressive Mode with Nuclei**:
    ```bash
    ./easy_hunt.sh --aggressive --nuclei example.com
    ```

- **Generate AI-Based Summary and HTML Report**:
    ```bash
    ./easy_hunt.sh --ai-summary --output report.html example.com
    ```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

### Additional Recommendations:
1. **Badges**: Consider adding badges for build status, license, and other key indicators at the top of the README (optional but adds credibility).
2. **Contributing Guidelines**: If you plan to have others contribute to the project, a section on how to contribute would be useful.

This README should help clarify the purpose of the project, how to set it up, and how to use it effectively.
