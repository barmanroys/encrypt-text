#!/usr/bin/env python3
# encoding:utf-8

"""
This module implements the helper functions for b64 encoding and decoding.
Author: Barman Roy, Swagato
"""
import logging
from base64 import b64encode, b64decode

logging.basicConfig(format='%(asctime)s | %(levelname)s: %(message)s',
                    level=logging.INFO)


def encode(plain_text: str) -> str:
    """Convert plain text to b64 encoded cipher."""
    logging.debug(msg=f'Encoding {plain_text}.')
    return b64encode(s=plain_text.encode()).decode()
