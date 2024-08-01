# Easy-Hunt

## AI-Enhanced Automated Bug Hunting Tool

### Developed by @iamsecure1920 - Team ICP

---

## Overview

Easy-Hunt is an automated bug hunting tool that leverages various open-source security tools and AI to identify and analyze potential vulnerabilities in web applications. The tool aims to streamline the bug hunting process, providing detailed reports and AI-driven insights for each scan.

---

## Features

- **Subdomain Enumeration**: Identifies subdomains of the target domain.
- **Live Domain Checking**: Verifies which subdomains are live.
- **Endpoint Collection**: Collects URLs and endpoints for further analysis.
- **XSS Vulnerability Check**: Detects potential cross-site scripting vulnerabilities.
- **JavaScript Analysis**: Analyzes JavaScript files for potential vulnerabilities.
- **Nuclei Vulnerability Scan**: Uses Nuclei to scan for known vulnerabilities.
- **Nmap Scan**: Performs detailed network scans for open ports and services.
- **SQLi Vulnerability Check**: Detects potential SQL injection vulnerabilities.
- **SSRF Vulnerability Check**: Identifies potential Server-Side Request Forgery vulnerabilities.
- **AI Analysis**: Provides AI-driven insights and analysis for each scan.
- **Aggressive Mode**: Optional aggressive mode for more thorough scans.

---

## Installation

1. **Clone the Repository**

    ```bash
    git clone https://github.com/iamsecure1920/easy-hunt.git
    cd easy-hunt
    ```

2. **Install Required Tools**

    ```bash
    ./Easy-Hunt.sh --install
    ```

3. **Configure API Key**

    Replace `YOUR_OPENAI_API_KEY` in the script with your actual OpenAI API key.

    ```bash
    nano Easy-Hunt.sh
    # Replace YOUR_OPENAI_API_KEY with your actual OpenAI API key
    ```

---

## Usage

### Basic Usage

To run Easy-Hunt against a target domain:

```bash
./Easy-Hunt.sh <target_domain>
