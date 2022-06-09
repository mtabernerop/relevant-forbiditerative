

# Filtering Top-k Relevant Plans

This repository proposes an interative approach to filter plans in top-k planning tasks under perfect justification criteria. Its implementation is based on Forbid-Iterative (FI) Planner, an Automated PDDL based planner that includes planners for top-k, top-quality, and diverse computational tasks, developed by Michael Katz et al.

## The planner is based on the idea of obtaining multiple solutions by iteratively reformulating planning tasks to restrict the set of valid plans, forbidding previously found ones. Solution plans are required to be relevant (perfectly-justified).

# Building
For building the code please use
```
./build.py
```

# Running
```
./plan_topk.sh <domain> <problem> <number-of-plans> <global-time> <plan-reorderings> <structural-symmetries>
```
Example of running command
```
./plan_topk.sh examples/blocks/domain.pddl examples/blocks/
```


## Citing

### Top-k Planning
```
@InProceedings{katz-et-al-icaps2018,
  title =        "A Novel Iterative Approach to Top-k Planning",
  author =       "Michael Katz and Shirin Sohrabi and Octavian Udrea and Dominik Winterer",
  booktitle =    "Proceedings of the Twenty-Eighth International Conference on
                  Automated Planning and Scheduling (ICAPS 2018)",
  publisher =    "{AAAI} Press",
  pages =        "132--140",
  year =         "2018"
}
```

### Relevant Top-k Planning
```
@misc{tabernero22actionfiltering,
  title =         {Relevant Action Filtering in Automated Planning},
  author =        {Tabernero Palomar, Miguel},
  howpublished =  {Bachelor Thesis},
  note =          {Universidad Carlos III de Madrid},
  year =          2022,
  language =      {English},
  addendum =      {unpublished thesis}
}
```


## Licensing

Forbid-Iterative (FI) Planner is an Automated PDDL based planner that
includes planners for top-k, top-quality, and diverse computational
tasks. Copyright (C) 2019  Michael Katz, IBM Research, USA.
The code extends the Fast Downward planning system. The license for the
extension is specified in the LICENSE file.

## Fast Downward
<img src="misc/images/fast-downward-logo.png" width="500" alt="Fast Downward">

Fast Downward is a domain-independent classical planning system.

Copyright 2003-2022 Fast Downward contributors (see below).

For further information:
- Fast Downward website: <https://www.fast-downward.org>
- Report a bug or file an issue: <https://issues.fast-downward.org>
- Fast Downward mailing list: <https://groups.google.com/forum/#!forum/fast-downward>
- Fast Downward main repository: <https://github.com/aibasel/downward>


## Tested software versions

This version of Fast Downward has been tested with the following software versions:

| OS           | Python | C++ compiler                                                     | CMake |
| ------------ | ------ | ---------------------------------------------------------------- | ----- |
| Ubuntu 20.04 | 3.8    | GCC 9, GCC 10, Clang 10, Clang 11                                | 3.16  |
| Ubuntu 18.04 | 3.6    | GCC 7, Clang 6                                                   | 3.10  |
| macOS 10.15  | 3.6    | AppleClang 12                                                    | 3.19  |
| Windows 10   | 3.6    | Visual Studio Enterprise 2017 (MSVC 19.16) and 2019 (MSVC 19.28) | 3.19  |

We test LP support with CPLEX 12.9, SoPlex 3.1.1 and Osi 0.107.9.
On Ubuntu, we test both CPLEX and SoPlex. On Windows, we currently
only test CPLEX, and on macOS, we do not test LP solvers (yet).


## Contributors

The following list includes all people that actively contributed to
Fast Downward, i.e. all people that appear in some commits in Fast
Downward's history (see below for a history on how Fast Downward
emerged) or people that influenced the development of such commits.
Currently, this list is sorted by the last year the person has been
active, and in case of ties, by the earliest year the person started
contributing, and finally by last name.

- 2003-2022 Malte Helmert
- 2008-2016, 2018-2022 Gabriele Roeger
- 2010-2022 Jendrik Seipp
- 2010-2011, 2013-2022 Silvan Sievers
- 2012-2022 Florian Pommerening
- 2013, 2015-2022 Salomé Eriksson
- 2018-2022 Patrick Ferber
- 2021-2022 Clemens Büchner
- 2021-2022 Dominik Drexler
- 2022 Remo Christen
- 2015, 2021 Thomas Keller
- 2016-2020 Cedric Geissmann
- 2017-2020 Guillem Francès
- 2018-2020 Augusto B. Corrêa
- 2020 Rik de Graaff
- 2015-2019 Manuel Heusner
- 2017 Daniel Killenberger
- 2016 Yusra Alkhazraji
- 2016 Martin Wehrle
- 2014-2015 Patrick von Reth
- 2009-2014 Erez Karpas
- 2014 Robert P. Goldman
- 2010-2012 Andrew Coles
- 2010, 2012 Patrik Haslum
- 2003-2011 Silvia Richter
- 2009-2011 Emil Keyder
- 2010-2011 Moritz Gronbach
- 2010-2011 Manuela Ortlieb
- 2011 Vidal Alcázar Saiz
- 2011 Michael Katz
- 2011 Raz Nissim
- 2010 Moritz Goebelbecker
- 2007-2009 Matthias Westphal
- 2009 Christian Muise


## History

The current version of Fast Downward is the merger of three different
projects:

- the original version of Fast Downward developed by Malte Helmert
  and Silvia Richter
- LAMA, developed by Silvia Richter and Matthias Westphal based on
  the original Fast Downward
- FD-Tech, a modified version of Fast Downward developed by Erez
  Karpas and Michael Katz based on the original code

In addition to these three main sources, the codebase incorporates
code and features from numerous branches of the Fast Downward codebase
developed for various research papers. The main contributors to these
branches are Malte Helmert, Gabi Röger and Silvia Richter.


## License

The following directory is not part of Fast Downward as covered by
this license:

- ./src/search/ext

For the rest, the following license applies:

```
Fast Downward is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

Fast Downward is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
```
