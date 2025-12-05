#venv

venv\Scripts\activate

# Compilation
pyinstaller --onefile malware.py
pyinstaller --onefile obfuscation.py