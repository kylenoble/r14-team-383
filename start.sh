#!/bin/bash
QUEUE=* rake environment resque:work
