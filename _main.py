#!/usr/bin/env python

import sys
from pathlib import Path
from datetime import datetime
from subprocess import run, DEVNULL


def save_log(level: str, message: str) -> None:
    script_name = Path(sys.argv[0]).name
    log_dir = Path.home() / ".local/state/shellscripts"
    log_dir.mkdir(parents=True, exist_ok=True)
    log_file = log_dir / f"{script_name}.log"

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = f"[{timestamp}] [{level}] {message}\n"

    with open(log_file, "a", encoding="utf-8") as f:
        f.write(log_entry)


def emit_message(sound: str, status: str, message: str) -> None:
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


def _log(message: str) -> None:
    timestamp = datetime.now().strftime("%H:%M:%S")
    status = f"\033[1m\033[30m [*] {timestamp} »"
    emit_message("message", status, message)
    save_log("DEBUG", message)


def _success(message: str) -> None:
    timestamp = datetime.now().strftime("%H:%M:%S")
    status = f"\033[1m\033[32m [+] {timestamp} »"
    emit_message("complete", status, message)
    save_log("INFO", message)


def _error(message: str) -> None:
    timestamp = datetime.now().strftime("%H:%M:%S")
    status = f"\033[1m\033[31m [-] {timestamp} »"
    emit_message("dialog-error", status, message)
    save_log("ERROR", message)


def _warning(message: str) -> None:
    timestamp = datetime.now().strftime("%H:%M:%S")
    status = f"\033[1m\033[33m [!] {timestamp} »"
    emit_message("dialog-warning", status, message)
    save_log("ALERT", message)


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

        _error(error_msg)
        sys.exit(1)
