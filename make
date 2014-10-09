#!/usr/bin/env python
import subprocess
import os
from glob import glob


BASENAME = 'huttone-two-page-cv'
VERBOSE = False

def system(args, verbose=False):
    print ' '.join(args)
    if VERBOSE:
        call = subprocess.check_call
    else:
        call = subprocess.check_output
    call(args)


def pdflatex(base):
    system(['pdflatex', '-halt-on-error', '-interaction=batchmode', base])


def bibtex(base):
    for auxfile in glob('%s[0-9]?aux' % base):
        system(['bibtex', auxfile])


def rm_f(path):
    try:
        os.remove(path)
    except OSError:
        pass


def all(base):
    print '==> ' + ' '.join(['make', 'all'])
    pdflatex(base)
    bibtex(base)
    pdflatex(base)
    pdflatex(base)


def clean(base):
    print '==> ' + ' '.join(['make', 'clean'])
    rm_f(base + '.log')
    rm_f(base + '.out')
    rm_f(base + '.pdf')
    files = glob('*.aux') + glob('*.bbl') + glob('*.blg')

    for file in files:
        rm_f(file)


def main():
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument('command', nargs='*', choices=['all', 'clean'],
                        default='all', help='Command [all]')
    parser.add_argument('--base', default=BASENAME,
                        help='Basename for file [%s]' % BASENAME)
    parser.add_argument('--verbose', action='store_true',
                        help='Be verbose')

    args = parser.parse_args()

    globals()['VERBOSE'] = args.verbose

    for cmd in args.command:
        if cmd == 'all':
            all(args.base)
        elif cmd == 'clean':
            clean(args.base)


if __name__ == '__main__':
    main()
