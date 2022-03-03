from __future__ import print_function

# -*- coding: utf-8 -*-

import contextlib
import os
import sys
import time

class Timer(object):
    def __init__(self):
        self.start_time = time.time()
        self.start_clock = self._clock()

    def _clock(self):
        times = os.times()
        # HACK, does not work on Windows: also add time used by child processes
        return times[0] + times[1] + times[2] + times[3]

    def __str__(self):
        return "[%.3fs CPU, %.3fs wall-clock]" % (
            self._clock() - self.start_clock,
            time.time() - self.start_time)

class ManualTimer:
    timers = dict()

    def __init__(self):
        self._start_time = None
        self._start_clock = None
        self._elapsed_time = 0
        self._elapsed_clock = 0

    def _clock(self):
        times = os.times()
        # HACK, does not work on Windows: also add time used by child processes
        return times[0] + times[1] + times[2] + times[3]
    
    def __str__(self):
        
        return "[%.3fs CPU, %.3fs wall-clock]" % (
            self._elapsed_clock,
            self._elapsed_time)

    def start(self):
        """Start a new timer"""
        if self._start_time is not None or self._start_clock is not None:
            raise TimerError(f"Timer is running. Use .stop() to stop it")

        self._start_time = time.time()
        self._start_clock = self._clock()

    def stop(self):
        """Stop the timer, and report the elapsed time"""
        if self._start_time is None or self._start_clock is None:
            return 0

        self._elapsed_time += time.time() - self._start_time
        self._elapsed_clock += self._clock() - self._start_clock
        self._start_time = None
        self._start_clock = None

class TimerError(Exception):
    """Custom TimerError exception class"""

@contextlib.contextmanager
def timing(text, block=False):
    timer = Timer()
    if block:
        print("%s..." % text)
    else:
        print("%s..." % text, end=' ')
    sys.stdout.flush()
    yield
    if block:
        print("%s: %s" % (text, timer))
    else:
        print(timer)
    sys.stdout.flush()
