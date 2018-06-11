#!/usr/bin/python
# -*- coding: utf-8 -*-
import argparse
import io
import os
import sys
import textwrap

blocks = [
    {
        'offset':  0x000058DE,
        'offset_eof':  0x00005AB6,
        'name': 'introduction',
        'content': '',
        'type': 1
    },
    {
        'offset':  0x000007996,
        'offset_eof':  0x000007A96,
        'name': 'ending',
        'content': '',
        'type': 1
    }
]

original_tbl = {
    # Numbers
    b'\x10': '0', b'\x11': '1', b'\x12': '2', b'\x13': '3', b'\x14': '4',
    b'\x15': '5', b'\x16': '6', b'\x17': '7', b'\x18': '8', b'\x19': '9',
    # Uppercase Characters
    b'\x1A': 'A', b'\x1B': 'B', b'\x1C': 'C', b'\x1D': 'D', b'\x1E': 'E',
    b'\x1F': 'F', b'\x20': 'G', b'\x21': 'H', b'\x22': 'I', b'\x23': 'J',
    b'\x24': 'K', b'\x25': 'L', b'\x26': 'M', b'\x27': 'N', b'\x28': 'O',
    b'\x29': 'P', b'\x2A': 'Q', b'\x2B': 'R', b'\x2C': 'S', b'\x2D': 'T',
    b'\x2E': 'U', b'\x2F': 'V', b'\x30': 'W', b'\x31': 'X', b'\x32': 'Y',
    b'\x33': 'Z',
    # Accents
    b'\x34': '!', b'\x36': ',', b'\x37': '..', b'\x38': '.',
    # Whitespace
    b'\x55': ' ',
    # Control Codes
    b'\xFE': '\n',
}


def get_control_line(value):
    return '[LINE: {:04d}]\n'.format(int.from_bytes(
        value, byteorder='big') & 0x00FF)


def get_control_column(value):
    return '[COLUMN: {:04d}]\n'.format(int.from_bytes(
        value, byteorder='big') & 0x00FF)


def get_control_speed(value):
    return '[SPEED: {:04d}]\n'.format(int.from_bytes(
        value, byteorder='big') & 0x00FF)


if __name__ == '__main__':
    """ Program Command Line """
    cmd = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=textwrap.dedent('''\
            [SMD] Castlevania Bloodlines (U) - Text Dumper
            ----------------------------------------------
            Tool for extract game scripts into text files,
            make the text readable and formatted to
            reinsertion
        ''')
    )
    cmd.add_argument(
        'infile',
        nargs='?',
        type=argparse.FileType('rb'),
        default=sys.stdin,
        help='Original [SMD] Castlevania Bloodlines (U) rom file.'
    )

    """ Program Main Routine """
    args = cmd.parse_args()
    if(args.infile.name != '<stdin>'):
        with args.infile as rom:
            for block in blocks:
                if block['type'] == 1:
                    rom.seek(block['offset'], 0)
                    block['content'] += '<START>\n'
                    block['content'] += get_control_line(rom.read(0x2))
                    block['content'] += get_control_column(rom.read(0x2))
                    block['content'] += get_control_speed(rom.read(0x2))
                    while rom.tell() < block['offset_eof']:
                        byte = rom.read(0x1)
                        next_byte = rom.read(0x1)
                        if(byte == b'\xFD') and (next_byte == b'\x00'):
                            block['content'] += '\n<END>\n\n<START>\n'
                            block['content'] += get_control_line(rom.read(0x2))
                            block['content'] += get_control_column(rom.read(0x2))
                            block['content'] += get_control_speed(rom.read(0x2))
                        else:
                            rom.seek(-1, 1)
                            if byte in original_tbl.keys():
                                block['content'] += (original_tbl[byte])
                            else:
                                pass
                    block['content'] += '\n<END>\n\n'
        try:
            os.stat('scripts')
        except:
            os.mkdir('scripts')
        for block in blocks:
            script = open('scripts/' + '.'.join(
                ['_'.join(['english', block['name']]), 'txt']), 'w+')
            for char in block['content']:
                script.write(char)
    else:
        cmd.print_help()
