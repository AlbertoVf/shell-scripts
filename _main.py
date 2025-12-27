#!/usr/bin/env python

import sys
from pathlib import Path
from datetime import datetime
from subprocess import run, DEVNULL
from enum import Enum


class MessageType(Enum):
    LOG = "log"
    SUCCESS = "success"
    ERROR = "error"
    WARNING = "warning"


class Message:
    def __init__(self):
        self.script_name = Path(sys.argv[0]).name
        self.log_dir = Path.home() / ".local/state/shellscripts"
        self.log_dir.mkdir(parents=True, exist_ok=True)
        self.log_file = self.log_dir / f"{self.script_name}.log"

        # Configuración de tipos de mensaje
        self.message_types = {
            MessageType.LOG: { "color": "\033[1m\033[30m", "symbol": "[*]", "sound": "message", "log_level": "DEBUG" },
            MessageType.SUCCESS: { "color": "\033[1m\033[32m", "symbol": "[+]", "sound": "complete", "log_level": "INFO" },
            MessageType.ERROR: { "color": "\033[1m\033[31m", "symbol": "[-]", "sound": "dialog-error", "log_level": "ERROR" },
            MessageType.WARNING: { "color": "\033[1m\033[33m", "symbol": "[!]", "sound": "dialog-warning", "log_level": "ALERT" }
        }

    def _save_log(self, level: str, message: str) -> None:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] [{level}] {message}\n"

        with open(self.log_file, "a", encoding="utf-8") as f:
            f.write(log_entry)

    def _emit_message(self, sound: str, status: str, message: str) -> None:
        if sys.stdout.isatty():
            reset = "\033[0m"
            print(f"{status} {message} {reset}", flush=True)
        else:
            print(message, flush=True)

        # Send desktop notification
        run(["notify-send", message], check=False, stdout=DEVNULL, stderr=DEVNULL)
        # Play sound
        sound_path = f"/usr/share/sounds/freedesktop/stereo/{sound}.oga"
        run(["paplay", sound_path], check=False, stdout=DEVNULL, stderr=DEVNULL)

    def _message(self, msg_type: MessageType, message: str) -> None:
        config = self.message_types[msg_type]
        timestamp = datetime.now().strftime("%H:%M:%S")
        status = f"{config['color']} {config['symbol']} {timestamp} »"

        self._emit_message(config['sound'], status, message)
        self._save_log(config['log_level'], message)

    def log(self, message: str) -> None:
        self._message(MessageType.LOG, message)

    def success(self, message: str) -> None:
        self._message(MessageType.SUCCESS, message)

    def error(self, message: str) -> None:
        self._message(MessageType.ERROR, message)

    def warning(self, message: str) -> None:
        self._message(MessageType.WARNING, message)


# Instancia global de Message
_message = Message()

def _params_required(num_params: int) -> None:
    if len(sys.argv) - 1 < num_params:
        # Try to get usage from script header comment
        usage = ""
        script_path = Path(sys.argv[0])
        with open(script_path, "r", encoding="utf-8") as f:
            for line in f:
                if line.startswith("# ? usage"):
                    usage = line.replace("# ? usage", "").strip()
                    break

        error_msg = f"El script requiere {num_params} parámetro(s)"
        if usage:
            error_msg += f"\n{usage}"

        _message.error(error_msg)
        sys.exit(1)

def _valid_files(args) -> list[Path]:
    files = []
    for f in args:
        path = Path(f)
        if path.exists() and path.is_file():
            files.append(path)

    if not files:
        _message.error("No se encontraron archivos válidos")
        sys.exit(1)
    return files
