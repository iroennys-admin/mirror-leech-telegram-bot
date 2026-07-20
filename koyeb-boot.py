#!/usr/bin/env python3
"""Boot script for Koyeb: healthcheck + bot in one process."""
import socket, subprocess, sys, threading, os

os.chdir('/app')

def healthcheck():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    try:
        s.bind(('0.0.0.0', 8000))
        s.listen(5)
    except Exception as e:
        sys.stderr.write(f'healthcheck bind failed: {e}\n')
        return
    while True:
        c, a = s.accept()
        c.send(b'HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nok')
        c.close()

threading.Thread(target=healthcheck, daemon=True).start()

sys.exit(subprocess.call(['bash', os.path.join(os.path.dirname(__file__), 'start.sh')]))
