#!/usr/bin/env python3

import pyasn
import pprint

asndb = pyasn.pyasn("bgp_archive.dat")
prefixes = asndb.get_as_prefixes(59162)

pp = pprint.PrettyPrinter(depth=4)
pp.pprint(prefixes)
