import json
import os
import re
import string
import subprocess
from Crypto.Util.number import bytes_to_long, getPrime, isPrime, long_to_bytes
from collections import defaultdict
from hashlib import sha256
from math import gcd, log, sqrt
from pwn import b64d, b64e

def call(*commands):
    """ Runs the command in the console.

    >>> call('echo', 'hello')
    'hello\n'
    """
    p = subprocess.Popen(commands, stdout=subprocess.PIPE)
    return p.communicate()[0]

def find_factor(n):
    """ Returns a positive integer >= 2 that divides n.

    >>> find_factor(45)
    3
    """
    if n % 2 == 0:
        return 2
    d = 3
    while d * d <= n:
        if n % d == 0:
            return d
        d += 2
    return n

def is_prime(n):
    return find_factor(n) == n

def factor(n):
    """ Returns a list of all factors of n.

    >>> factor(45)
    [3, 3, 5]
    """
    l = []
    while n > 1:
        d = find_factor(n)
        l.append(d)
        n //= d
    return l

def nCr(a, b):
    if b < 0:
        return 0
    n = 1
    for i in range(b):
        n *= a - i
        n //= i + 1
    return n

def nth_root(x, n):
    low = 0
    high = x
    while low + 1 < high:
        mid = (low + high) // 2
        if mid ** n <= x:
            low = mid
        else:
            high = mid
    return low

def extended_gcd(a, b):
    if a == 0:
        return 0, 1
    x, y = extended_gcd(b % a, a)
    return y - b // a * x, x

