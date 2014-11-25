AntiPhish
A URL scanner which expands shortened links and scans the destination using publicly available APIs.

Resources used:
- Google Safe Browsing API
- VirusTotal API
- LongURL.org API
- Metascan API
- Tethr UI Pack
- Alamofire
- SwiftyJSON

Current Functionality:
- Input URL for scanning
- Output quickly tells you if the site is "Clean" or "Suspicious"
- Output also has details as explaining the judgment.

Planned Functionality:
- Try to fix Metascan API.
	- Parameters are sent via custom HTTP Headers
	- Having crash issues when using custom HTTP Headers in Alamofire.
- Update UI to show the expanded URL if (and only if) the input was a shortened URL
- Implement the help page overlay.
- Add animations so the transition from main page to scan page is correct.