#!/usr/bin/python
# -*- coding: utf-8 -*-
import argparse
import io
import os
import sys
import textwrap


class LZData(object):
  """ LZ Compressed Byte values"""

  def __init__(self, lenght=0x0, offset=0x0):
    self.lenght = lenght
    self.offset = offset


class LZWindow(object):
  """Circular Window with Fixed Width"""

  def __init__(self, size=0x3FF, offset=0x0, fill=b'\x00'):
    self._buffer = io.BytesIO()
    self.offset = offset
    self.size = size
    self._fill = fill
    # Fill entire new Window with 0x00
    if (type(self._fill).__name__ == 'int'):
      self._fill = self._fill.to_bytes(1, byteorder='big')
    for x in range(0, size):
      self._buffer.write(fill)
    # Put the cursor on specified window start offset
    self._buffer.seek(self.offset)

  def get(self, bytes=0x1, offset=False, int_conversion=False):
    # Seek current offset
    self._buffer.seek(self.offset)
    # if offset specified, move cursor to specified location
    # otherwise seek current offset for secure
    if (offset is not False):
      self._buffer.seek(offset)
    # Get the Value on Window at offset
    value = self._buffer.read(0x1)
    # Seek back to window position before get
    self._buffer.seek(self.offset)
    # If int_conversion specified return an int else return byte
    if (int_conversion == True):
      value = int.from_bytes(value, byteorder='big')
    return value

  def push(self, value, offset=False):
    # if type of value is an int, convert to byte
    if (type(value).__name__ == 'int'):
      value = value.to_bytes(1, byteorder='big')
    # if offset specified, move cursor to specified location
    # otherwise seek current offset for secure
    self._buffer.seek(self.offset)
    if (offset is not False):
      self._buffer.seek(offset & window.size)
    # write Value on Window
    self._buffer.write(value)
    # increment and seek back to window position
    self.offset = (self.offset + 0x1) & self.size
    self._buffer.seek(self.offset)


if __name__ == '__main__':
  """ Program Command Line """
  cmd = argparse.ArgumentParser(
      formatter_class=argparse.RawDescriptionHelpFormatter,
      description=textwrap.dedent('''\
            [SMD] LZ Konami Type 3 - Decoder
            ----------------------------------------------
            Tool for extract images from games developed
            by Konami and using LZ Type 3 algorithm of
            compression
            ----------------------------------------------
            List of know compatible games;
            Castlevania - Bloodlines
            Hyper Dunk - The Playoff Edition
            Lethal Enforcers
            Teenage Mutant Ninja Turtles - Tournament Fighters
            Tiny Toon Adventures - Acme All-Stars
        ''')
  )
  cmd.add_argument(
      'infile',
      nargs='?',
      type=argparse.FileType('rb'),
      default=sys.stdin,
      help='Original Genesis / Mega Drive rom file.'
  )

  """ Program Main Routine """
  args = cmd.parse_args()
  if(args.infile.name != '<stdin>'):
    with args.infile as rom:
      rom.seek(0xa8336)
      # Initialize a clear buffer for Output Data
      output = io.BytesIO()
      # Initialize a new LZWindow for Decompression
      window = LZWindow(offset=0x3df)
      # Get the decompressed size of Data
      decompressed_size = int.from_bytes(rom.read(2), byteorder='big')
      # Set total of decompressed bytes to 0
      decompressed_bytes = 0
      # Start decompression
      while (decompressed_bytes < decompressed_size):
        # Get the bitmask of compression
        bitmask = rom.read(1)
        # Set total of bits to read to 7 (1 Byte)
        rbits = 7
        # While read current bitmask
        while(rbits >= 0):
          # Initalize a new LZData for storage of compressed byte data
          lzdata = LZData()
          # Read 1 byte from rom
          buffer = rom.read(1)
          # Get the current bit value of bitmask
          control_flag = (int.from_bytes(
              bitmask, byteorder='big') >> (7 - rbits)) & 0x1
          # If bit is 0, copy uncompressed data to LZWindow and Output Buffer
          if (control_flag == 0):
            output.write(buffer)
            window.push(buffer)
            # Increment decompressed bytes
            decompressed_bytes += 1
          # If bit is 1, decompress data
          else:
            # if compressed byte is lower than 0x80
            if (int.from_bytes(buffer, byteorder='big') < 0x80):
              # if compressed byte is 0x1F, terminate loop
              if (int.from_bytes(buffer, byteorder='big') == 0x1F):
                break
              # othertwise process length and offset on byte
              # lenght is byte&0x1f + 3
              # offset is (byte&0x60) << 3 + newbyte
              # store values on LZData
              lenght = (int.from_bytes(buffer, byteorder='big') & 0x1F) + 3
              offset = ((int.from_bytes(buffer, byteorder='big') &
                         0x60) << 3) | int.from_bytes(rom.read(1), byteorder='big')
              lzdata = LZData(lenght, offset)

            # if compressed byte is bigger than 0x80 but lower than 0xC0
            elif (int.from_bytes(buffer, byteorder='big') >= 0x80 and int.from_bytes(buffer, byteorder='big') <= 0xC0):
              # othertwise process length and offset on byte
              # lenght is (byte>>4)&0x3 + 3
              # offset is window current offset - ((byte0xF) & window size)
              # store values on LZData
              lenght = ((int.from_bytes(buffer, byteorder='big') >> 4) & 3) + 2
              offset = (window.offset - (int.from_bytes(buffer,
                                                        byteorder='big') & 0xF)) & window.size
              lzdata = LZData(lenght, offset)
            # if compressed byte is bigger than 0xC0
            else:
              # get compressed byte lenght (byte&0x3F)+8
              lenght = (int.from_bytes(buffer, byteorder='big') & 0x3F) + 8
              # then copy next X bytes from input direct to LZWindow and output buffer
              while (lenght > 0):
                buffer = rom.read(1)
                output.write(buffer)
                window.push(buffer)
                lenght -= 1
                decompressed_bytes += 1
            # copy lzdata from window to: window and output buffer
            while(lzdata.lenght > 0):
              wnd_buffer = window.get(
                  0x1, lzdata.offset)
              output.write(wnd_buffer)
              window.push(wnd_buffer)
              lzdata.lenght -= 1
              lzdata.offset = (lzdata.offset + 1) & window.size
              decompressed_bytes += 1
          rbits -= 1
    output.seek(0x0)
    with open('test.bin', 'wb') as dumpfile:
      dumpfile.write(output.read())
  else:
    cmd.print_help()
