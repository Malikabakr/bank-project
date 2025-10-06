# Card Delivery Document Processing System

A secure, privacy-first Flask application for generating card delivery documents with automatic data cleanup.

## 🔐 Security Features

- **Data Minimization**: Processes only last 4 digits of card numbers (no full PAN)
- **Automatic Deletion**: All data automatically removed within 2 minutes
- **No Sensitive Data**: No CVV, expiry dates, or magnetic stripe data stored
- **Session Isolation**: Each user session independently managed
- **Comprehensive Logging**: Full audit trail of all operations

## 📋 Requirements

- Python 3.8+
- Flask web framework
- Required libraries listed in `requirements.txt`

## 🚀 Installation & Deployment

### Option 1: Docker (Recommended) 🐳

**Quick Start:**
```bash
# Build and start with one command
make build up

# Or using docker-compose
docker-compose up --build -d
```

**Access the application:**
```
http://localhost:5048
```

**Manage containers:**
```bash
make logs      # View logs
make status    # Check status
make down      # Stop containers
make help      # See all commands
```

For detailed Docker instructions, see [DOCKER_README.md](DOCKER_README.md)

### Option 2: Local Python Installation

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Configure environment (optional):
```bash
cp .env.example .env
# Edit .env with your settings
```

3. Run the application:
```bash
python app.py
```

4. Access the application:
```
http://localhost:5048
```

## 📁 Project Structure

```
Project_bank/
├── app.py                              # Main application (ONLY Python file)
├── requirements.txt                    # Python dependencies
├── .env                                # Environment variables (not in git)
├── .env.example                        # Environment template
├── Dockerfile                          # Docker image definition
├── docker-compose.yml                  # Docker orchestration
├── .dockerignore                       # Docker build exclusions
├── Makefile                            # Convenient Docker commands
├── README.md                           # Main documentation
├── DOCKER_README.md                    # Docker deployment guide
├── NotoNaskhArabic-Regular.ttf        # Arabic font support
├── times.ttf                          # Times font
├── docker-*.sh                        # Helper scripts
├── static/                            # Static assets
│   ├── card_templates/                # PDF templates
│   ├── css/                           # Stylesheets
│   ├── js/                            # JavaScript files
│   └── uploads/                       # Temporary uploads (auto-deleted)
├── templates/                         # HTML templates
└── PCI_DSS_Compliance_Report.*        # Security compliance documentation
```

## 🎯 Features

- **Card Types Supported**:
  - Platinum Cards
  - Business Cards
  - Corporate Cards
  - ISIC (International Student Identity Card)
  - ITIC (International Teacher Identity Card)
  - IYTC (International Youth Travel Card)
  - A4 Collection Forms

- **Document Processing**:
  - Excel to PDF conversion with Arabic/Kurdish support
  - PDF editing and annotation
  - Word to PDF conversion
  - PDF to Word conversion
  - Batch processing with progress tracking

- **Data Handling**:
  - Processes: Activation codes, last 4 digits, names, addresses, phone numbers
  - Does NOT store: Full card numbers, CVV, expiry dates, magnetic stripe data
  - Automatic cleanup: 2-minute file retention policy

## ⚙️ Configuration

### File Retention
```python
FILE_AGE_LIMIT = 2      # Files deleted after 2 minutes
CLEANUP_INTERVAL = 1    # Cleanup runs every 1 minute
```

### Upload Limits
```python
MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max file size
```

## 🔒 Security & Compliance

See `PCI_DSS_Compliance_Report.md` for detailed security assessment and PCI DSS alignment.

**Key Compliance Points**:
- ✅ Data minimization (last 4 digits only)
- ✅ No sensitive authentication data storage
- ✅ Automatic deletion within 2 minutes
- ✅ Session-based isolation
- ✅ Comprehensive audit logging
- ✅ Internal network architecture

## 📝 API Endpoints

### Card Forms
- `/` - Home page
- `/card_selection` - Card type selection
- `/platinum_form` - Platinum card form
- `/business_form` - Business card form
- `/corporate_form` - Corporate card form
- `/isic_form` - ISIC form
- `/itic_form` - ITIC form
- `/iytc_form` - IYTC form

### File Operations
- `/upload_excel` (POST) - Upload and process Excel file
- `/download/<filename>` - Download generated files
- `/progress` - Check processing progress

### Conversions
- `/excel_to_pdf` - Simple Excel to PDF table conversion
- `/pdf_to_word` - PDF to Word conversion
- `/word_to_pdf` - Word to PDF conversion
- `/pdf_editor` - PDF editing interface

## 🧹 Automatic Cleanup

The application runs a background scheduler that:
1. Checks for old files every 1 minute
2. Deletes files older than 2 minutes
3. Logs all deletion operations
4. Maintains required directory structure

## 🌐 Browser Support

- Modern browsers (Chrome, Firefox, Safari, Edge)
- JavaScript enabled required for progress tracking

## 📊 Logging

All operations are logged with timestamps:
- File uploads and processing
- PDF generation
- File deletions
- Error tracking
- Cleanup summaries

## 🛡️ Privacy Protection

This system is designed with privacy-first principles:
- Minimal data collection
- Purpose limitation
- Storage limitation (2 minutes)
- Automatic data deletion
- Session isolation

## 📞 Support

For security concerns or compliance questions, refer to:
- `PCI_DSS_Compliance_Report.md` - Detailed security analysis
- `PCI_DSS_Compliance_Report.docx` - Word format report

## 🔄 Updates

To update dependencies:
```bash
pip install --upgrade -r requirements.txt
```

## ⚠️ Important Notes

1. **Internal Use Only**: Designed for internal network deployment
2. **Data Lifecycle**: All uploaded data is automatically deleted after 2 minutes
3. **No Database**: No persistent storage of cardholder data
4. **Arabic Support**: Full RTL (Right-to-Left) language support included
5. **Font Requirements**: Arabic and Times fonts must be in project root

## 📄 License

Internal use only. All rights reserved.

## 🎉 Clean Architecture

This project follows a **single-file architecture** for simplicity:
- ✅ One Python file (`app.py`)
- ✅ Minimal dependencies
- ✅ No unnecessary libraries
- ✅ Clean project structure
- ✅ Easy to maintain and deploy
