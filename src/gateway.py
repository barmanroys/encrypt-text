#!/usr/bin/env python3
# encoding: utf-8

"""
Asynchronous gateway interface to expose the worker.

For development, start it by
    $ uvicorn gateway:webapp --host=0.0.0.0 --port=8080 --reload

Skip the reload option above in containerised production environment to exploit
concurrent processing and withstand moderate user traffic.

Author: Barman Roy, Swagato
"""
import os

from fastapi import Form, FastAPI
from uvicorn import run

from crypt_helper import logging, encode

DESCRIPTION: str = """
A basic ASGI for encrypting

# Clients

You will be able to:

* Submit encryption job
"""
webapp = FastAPI(title='Encryption Pipeline',
                 description=DESCRIPTION,
                 contact=dict(name='Barman Roy, Swagato',
                              email='swagatopablo@aol.com'))


@webapp.post(path='/encrypt/')
async def encrypt(text: str = Form(default='Hello world')) -> str:
    """Use this handler function to encrypt or decrypt."""
    logging.info(msg=f'{text} received.')

    result: str = encode(plain_text=text)
    logging.info(msg=f'Encryption returned {result}.')
    return result


if __name__ == '__main__':
    file: str = os.path.basename(p=__file__).split(sep='.')[0]
    appname: str = f'{file}:webapp'
    run(app=appname, host='0.0.0.0', port=8080, reload=True)
