#!/usr/bin/env python3
# vim: ts=4 sw=4 sts=4 et ai

import argparse
import json
import os
import sys
import zipfile

STD_IN_OUT = '-'

parser = argparse.ArgumentParser()
parser.add_argument('-s', '--size-data', default=STD_IN_OUT,
        help='json data which includes content size. "-" means stdin/stdout.')
parser.add_argument('-f', '--filename',
        default='app/build/outputs/bundle/developDebug/app-develop-debug.aab',
        help='location of apk/aab file')
parser.add_argument('-m', '--mode',
        choices=['calc', 'diff'],
        default='calc',
        help='save: save content size to size-data file\ndiff: print differents between size-data and apk/aab file')
parser.add_argument('-w', '--warning-threshold',
        type=int,
        default = 1024 * 100,
        help='diff threshold to raise warning')

parser.add_argument('-d', '--diff-threshold',
        type=int,
        default = 1024 * 10,
        help='diff threshold to display')

def get_head_branch():
    return os.environ.get('GITHUB_HEAD_REF', 'dev')

def get_base_branch():
    return os.environ.get('GITHUB_BASE_REF', 'dev')

def get_head_sha():
    return os.environ.get('GITHUB_BASE_SHA', '0' * 9)[:9]


def get_human_readable_size(size, decimal_places = 2):
    sign = '' if size > 0 else '-'
    size = abs(size)
    for unit in ('B', 'KB', 'MB', 'GB'):
        if size < 1024.0:
            break
        size /= 1024.0
    return f'{sign}{size:.{decimal_places}f}{unit}'

def is_dex(filename):
    return filename.endswith('.dex')

def is_bundle_metadata(filename):
    if filename == 'BundleConfig.pb':
        return True

    for pb in ('/assets.pb', '/resources.pb', '/native.pb' ):
        if filename.endswith(pb):
            return True

    if filename.startswith('BUNDLE-METADATA'):
        return True
    return False

def iter_content(apk_or_aab_filename):
    for info in zipfile.ZipFile(apk_or_aab_filename).infolist():
        if is_dex(info.filename):
            continue
        if is_bundle_metadata(info.filename):
            continue
        yield info.filename, info.compress_size


def save_size(fp, apk_or_aab_filename):
    contents = {}
    d = {
        'branch': get_head_branch(),
        'commit': get_head_sha(),
        'contents': contents
    }

    for filename, size in sorted(iter_content(apk_or_aab_filename)):
        contents[filename] = size

    json.dump(d, fp)


def print_diff_header(out, size_data):
    old_commit = size_data['commit']
    new_commit = get_head_sha()
    changes = f'{old_commit}...{new_commit}'
    print(f'| filename | {changes} |', file=out)
    print('| --- | --- |', file=out)

def print_diff_row(out, filename, diff):
    print(f'| {filename} | {diff} |', file=out)

def diff_size(out, size_data, args):
    contents = size_data.get('contents', {})
    print_diff_header(out, size_data)

    total = 0
    for filename, size in sorted(iter_content(args.filename)):
        total += size
        old_size = contents.get(filename, 0)
        if abs(old_size - size) > args.diff_threshold:
            print_diff_row(out, filename, get_human_readable_size(size - old_size))
    total_diff = total - sum(contents.values())
    print_diff_row(out, 'TOTAL', get_human_readable_size(total_diff))

    return total_diff > args.warning_threshold


if __name__ == '__main__':
    args = parser.parse_args(sys.argv[1:])

    if args.mode == 'calc':
        if args.size_data == STD_IN_OUT:
            json_file = sys.stdout
        else:
            json_file = open(args.size_data, 'w')
        save_size(json_file, args.filename)
    elif args.mode == 'diff':
        if args.size_data == STD_IN_OUT:
            json_file = sys.stdin
        else:
            json_file = open(args.size_data)
        sys.exit(diff_size(sys.stdout, json.load(json_file), args))
    else:
        assert False
