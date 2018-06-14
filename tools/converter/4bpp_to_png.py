#!/usr / bin / python
# -*- coding: utf-8 -*-
import argparse
import io
import os
import sys
import textwrap

from PIL import Image

if __name__ == '__main__':
  """ Program Command Line """
  cmd = argparse.ArgumentParser(
      formatter_class=argparse.RawDescriptionHelpFormatter,
      description=textwrap.dedent('''\
            [SMD] Sega Genesis / Mega Drive 4BPP to PNG
            ----------------------------------------------
            Tool for convert Sega Genesis / Mega Drive
            4BPP tiles to PNG
        ''')
  )
  cmd.add_argument(
      'infile',
      nargs='?',
      type=argparse.FileType('rb'),
      default=sys.stdin,
      help='4BPP binary file.'
  )

  cmd.add_argument(
      'output',
      nargs='?',
      type=str,
      default='image.png',
      help='Output PNG filename.'
  )

  cmd.add_argument(
      'cols',
      nargs='?',
      type=int,
      default=16,
      help='Total of tile columns on Image'
  )

  cmd.add_argument(
      'lines',
      nargs='?',
      type=int,
      default=16,
      help='Total of lines on Image'
  )

  cmd.add_argument(
      'alpha',
      nargs='?',
      type=bool,
      default=False,
      help='if set 1 black will be transparent'
  )

  """ Program Main Routine """
  args = cmd.parse_args()
  if(args.infile.name != '<stdin>'):
    with args.infile as bindata:
      # Get the size of bindata
      bindata.seek(0, 2)
      binlen = bindata.tell()
      bindata.seek(0, 0)

      image_width = (args.cols * 8)
      image_height = (args.lines * 8)

      # Create a new output image buffer
      outputImage = Image.new(
          'RGBA', (image_width, image_height), (255, 0, 0, 0))
      # Load Pixel Map
      pixels = outputImage.load()
      # Clear Buffer
      buffer = 0
      # For byte in binary (multiply by 2 cause each byte has 2 pixels in 4bpp)
      for i in range(0, binlen * 2):
        # If i is modulo of 2, read new byte
        if (i % 2 == 0):
          buffer = int.from_bytes(bindata.read(1), byteorder='big')
          pixel = (buffer >> 4) & 0xF
        # Else get the second pixel on last byte
        else:
          pixel = buffer & 0xF
        # Each tile column is result of modulo 8
        column = int(i % 8)
        # Each tile line is result of division by 8 then modulo 8
        line = (int(i / 8) % 8)
        # Each tile is result of division by 64 = 8 columns * 8 lines
        tile = int(i / 64)
        # Each pixel bit is 1 color (multiply by 100 to convert to RGB)
        if args.alpha == True:
          if pixel == 0x0:
            A = 0
          else:
            A = 255
        else:
          A = 255
        B = ((pixel >> 1) & 0x1) * 100
        G = ((pixel >> 2) & 0x1) * 100
        R = ((pixel >> 3) & 0x1) * 100
        # Get X , Y and put on Image
        x = column + int((tile * 8) % image_width)
        y = line + int((tile * 8) / image_width) * 8

        print(column, line, tile)
        print(x, y)
        pixels[x, y] = (R, G, B, A)
    try:
      os.stat('gfx')
    except:
      os.mkdir('gfx')
    outputImage.save('gfx/' + args.output, dpi=(300, 300))
  else:
    cmd.print_help()
