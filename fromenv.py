#!/usr/bin/env python3

import os



def main ():
    ENV_USER = os.getenv('USER')
    print(ENV_USER, end=' (-_-) (o_O)')


if __name__ == '__main__':
   main()

