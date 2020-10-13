#!/usr/bin/python
# -*- coding: utf-8 -*-
import argparse
import io
import os
import sys
import textwrap

if __name__ == '__main__':
    """ Program Command Line """
    cmd = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=textwrap.dedent('''\
                [SMD] ROM Expander
                ----------------------------------------------
                Tool for expand Genesis / Mega Drive rom file
            ''')
    )

    cmd.add_argument(
            'infile',
            nargs='?',
            type=argparse.FileType('rb'),
            default=sys.stdin,
            help='Original Genesis / Mega Drive rom file.'
    )

    cmd.add_argument(
        'outfile',
        nargs='?',
        type=argparse.FileType('wb'),
        default=sys.stdin,
        help='Expanded Genesis / Mega Drive rom file.'
    )

    """ Program Main Routine """

    # Reset Checksum Value
    newSize = 0
    romBuffer = b""
    romSize = 0
    # Parse command line
    args = cmd.parse_args()
    # Start Original ROM checksum calculation
    if(args.infile.name != '<stdin>'):
        with args.infile as rom:
            # Copy original ROM to Buffer
            rom.seek(0x0,0)
            romSize = os.path.getsize(rom.name)
            newSize = romSize * 2
            romBuffer = rom.read(romSize)
            # Close
            rom.close()
    # Open outfile to write patched checksum
    if(args.outfile.name != '<stdin>'):
        with args.outfile as rom:
            rom.seek(0x0,0)
            # Write old ROM file
            rom.write(romBuffer)
            # Write new ROM Size
            rom.seek(0x1A4,0)
            rom.write(newSize.to_bytes(4,'big'))
            # Fill ROM with 0x0 until reachs new size
            rom.seek(romSize,0)
            while (rom.tell() < newSize):
                rom.write(b"\x00")
            # Close
            rom.close()
    # Print usage
    else:
        cmd.print_usage()