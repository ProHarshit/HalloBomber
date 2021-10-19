import os
import shutil
import sys
import subprocess
import string
import random
import json
import re
import time
import argparse
import zipfile
from io import BytesIO

from concurrent.futures import ThreadPoolExecutor, as_completed

from utils.decorators import MessageDecorator
from utils.provider import APIProvider

try:
    import requests
    from colorama import Fore, Style
except ImportError:
    print("\tSome dependencies could not be imported (possibly not installed)")
    print(
        "Type `pip3 install -r requirements.txt` to "
        " install all required packages")
    sys.exit(1)


def clr():
    if os.name == "nt":
        os.system("cls")
    else:
        os.system("clear")


def readisdc():
    with open("isdcodes.json") as file:
        isdcodes = json.load(file)
    return isdcodes

    print()


def check_intr():
    try:
        requests.get("https://motherfuckingwebsite.com")
    except Exception:
         
        mesgdcrt.FailureMessage("Poor internet connection detected")
        sys.exit(2)


def format_phone(num):
    num = [n for n in num if n in string.digits]
    return ''.join(num).strip()


def get_phone_info():
    while True:
        target = ""
        print()
        cc = input(mesgdcrt.CommandMessage(
            "\033[36mEnter your country code (Without +): \033[32m"))
        cc = format_phone(cc)
        if not country_codes.get(cc, False):
            mesgdcrt.WarningMessage(Fore.RED + "The country code ({cc}) that you have entered is invalid or unsupported".format(cc=cc))
            continue
        print()
        target = input(mesgdcrt.CommandMessage(
            "\033[36mEnter the target number:\033[32m +" + cc + " "))
        target = format_phone(target)
        if ((len(target) <= 6) or (len(target) >= 12)):
            mesgdcrt.WarningMessage(
                "\033[31m The phone number ({target})".format(target=target) +
                "\033[31m that you have entered is invalid")
            continue
        return (cc, target)


def get_mail_info():
    mail_regex = r'^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$'
    while True:
        target = input(mesgdcrt.CommandMessage("Enter target mail: "))
        if not re.search(mail_regex, target, re.IGNORECASE):
            mesgdcrt.WarningMessage(
                "The mail ({target})".format(target=target) +
                " that you have entered is invalid")
            continue
        return target


def pretty_print(cc, target, success, failed):
    requested = success+failed
    mesgdcrt.SectionMessage(Fore.GREEN + "Bombing is in progress - Please be patient")
    mesgdcrt.GeneralMessage(
        Fore.GREEN + "Please stay connected to the internet during bombing")
    mesgdcrt.GeneralMessage(Fore.GREEN + "Target       : " + cc + " " + target)
    mesgdcrt.GeneralMessage(Fore.GREEN + "Sent         : " + str(requested))
    mesgdcrt.GeneralMessage(Fore.GREEN + "Successful   : " + str(success))
    mesgdcrt.GeneralMessage(Fore.RED + "Failed       : " + str(failed))
    mesgdcrt.WarningMessage(
        Fore.GREEN + "This tool was made for fun and research purposes only")
    

def workernode(mode, cc, target, count, delay, max_threads):

    api = APIProvider(cc, target, mode, delay=delay)
    clr()
    mesgdcrt.SectionMessage("Gearing up the Bomber - Please be patient")
    mesgdcrt.GeneralMessage(
        Fore.GREEN + "Please stay connected to the internet during bombing")
    mesgdcrt.GeneralMessage(Fore.GREEN + "API Version   : " + api.api_version)
    mesgdcrt.GeneralMessage(Fore.GREEN + "Target        : " + cc + target)
    mesgdcrt.GeneralMessage(Fore.GREEN + "Amount        : " + str(count))
    mesgdcrt.GeneralMessage(Fore.GREEN + "Threads       : " + str(max_threads) + " threads")
    mesgdcrt.GeneralMessage(Fore.GREEN + "Delay         : " + str(delay) +
                            " seconds")
    mesgdcrt.WarningMessage(
        Fore.GREEN + "This tool was made for fun and research purposes only")
    print()
    input(mesgdcrt.CommandMessage(
        Fore.GREEN + "Press [CTRL+Z] to suspend the bomber or [ENTER] to resume it"))

    if len(APIProvider.api_providers) == 0:
        mesgdcrt.FailureMessage("Your country/target is not supported yet")
        mesgdcrt.GeneralMessage("Feel free to reach out to us")
        input(mesgdcrt.CommandMessage("Press [ENTER] to exit"))
         
        sys.exit()

    success, failed = 0, 0
    while success < count:
        with ThreadPoolExecutor(max_workers=max_threads) as executor:
            jobs = []
            for i in range(count-success):
                jobs.append(executor.submit(api.hit))

            for job in as_completed(jobs):
                result = job.result()
                if result is None:
                    mesgdcrt.FailureMessage(
                        "Bombing limit for your target has been reached")
                    mesgdcrt.GeneralMessage("Try Again Later !!")
                    input(mesgdcrt.CommandMessage("Press [ENTER] to exit"))
                     
                    sys.exit()
                if result:
                    success += 1
                else:
                    failed += 1
                clr()
                pretty_print(cc, target, success, failed)
    print("\n")
    mesgdcrt.SuccessMessage("Bombing completed!")
    time.sleep(1.5)
     
    sys.exit()


def selectnode(mode="sms"):
    mode = mode.lower().strip()
    try:
        check_intr()
         

        max_limit = {"sms": 500, "call": 15, "mail": 200}
        cc, target = "", ""
        if mode in ["sms", "call"]:
            cc, target = get_phone_info()
            if cc != "91":
                max_limit.update({"sms": 100})
        elif mode == "mail":
            target = get_mail_info()
        else:
            raise KeyboardInterrupt

        limit = max_limit[mode]
        while True:
            try:
                print()
                message = ("\033[36mEnter number of {type}".format(type=mode.upper()) +
                           "\033[36m to send (Max {limit}): \033[32m".format(limit=limit))
                count = int(input(mesgdcrt.CommandMessage(message)).strip())
                if count > limit or count == 0:
                    mesgdcrt.WarningMessage("You have requested " + str(count)
                                            + " {type}".format(
                                                type=mode.upper()))
                    mesgdcrt.GeneralMessage(
                        "Automatically capping the value"
                        " to {limit}".format(limit=limit))
                    count = limit
                print()
                delay = float(input(
                    mesgdcrt.CommandMessage("\033[36mEnter delay time (in seconds): \033[32m"))
                    .strip())
                # delay = 0
                max_thread_limit = (count//10) if (count//10) > 0 else 1
                print()
                max_threads = int(input(
                    mesgdcrt.CommandMessage("\033[36mEnter Number of Thread (Recommended: {max_limit}): \033[32m"
                        .format(max_limit=max_thread_limit)))
                    .strip())
                max_threads = max_threads if (
                    max_threads > 0) else max_thread_limit
                if (count < 0 or delay < 0):
                    raise Exception
                break
            except KeyboardInterrupt as ki:
                raise ki
            except Exception:
                mesgdcrt.FailureMessage("Read Instructions Carefully !!!")
                print()

        workernode(mode, cc, target, count, delay, max_threads)
    except KeyboardInterrupt:
        mesgdcrt.WarningMessage("Received INTR call - Exiting...")
        sys.exit()


mesgdcrt = MessageDecorator("icon")
if sys.version_info[0] != 3:
    mesgdcrt.FailureMessage("HalloBomber will work only in Python v3")
    sys.exit()

try:
    country_codes = readisdc()["isdcodes"]
except FileNotFoundError:
    update()


ALL_COLORS = [Fore.GREEN, Fore.RED, Fore.YELLOW, Fore.BLUE,
              Fore.MAGENTA, Fore.CYAN, Fore.WHITE]
RESET_ALL = Style.RESET_ALL

ASCII_MODE = False
DEBUG_MODE = False

selectnode(mode="sms")