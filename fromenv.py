#!/usr/bin/env python3

import os



def main ():
    ENV_USER = os.getenv('USER')
    print(ENV_USER)


if __name__ == '__main__':
   main()

