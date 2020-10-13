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
                [SMD] Fix Checksum
                ----------------------------------------------
                Tool for fix checksum of
                Genesis / Mega Drive rom file
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
        help='Fixed Genesis / Mega Drive rom file.'
    )

    """ Program Main Routine """

    # Reset Checksum Value
    newChecksum = 0
    romBuffer = b""
    # Parse command line
    args = cmd.parse_args()
    # Start Original ROM checksum calculation
    if(args.infile.name != '<stdin>'):
        with args.infile as rom:
            # Seek current checksum value
            rom.seek(0x18e,0)
            romChecksum = int.from_bytes(rom.read(0x2), 'big')
            print("Current Checksum: {:04X}".format(romChecksum))
            # Calculate Checksum value
            rom.seek(0x200,0)
            romSize = os.path.getsize(rom.name)
            while(rom.tell() < romSize):
                newChecksum += int.from_bytes(rom.read(0x2), 'big')
            print("Correct Checksum: {:04X}".format(newChecksum&65535))
            # Copy original ROM to Buffer
            rom.seek(0x0)
            romBuffer = rom.read(romSize)
            # Close
            rom.close()
    # Open outfile to write patched checksum
    if(args.outfile.name != '<stdin>'):
        with args.outfile as rom:
            # Write old ROM file
            rom.write(romBuffer)
            # Write new Checksum
            rom.seek(0x18e,0)
            rom.write((newChecksum&65535).to_bytes(2,'big'))
            # Close
            rom.close()
    # Print usage
    else:
        cmd.print_usage()