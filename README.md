[![Actions Status](https://github.com/lizmat/DateTime-strftime/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/DateTime-strftime/actions) [![Actions Status](https://github.com/lizmat/DateTime-strftime/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/DateTime-strftime/actions) [![Actions Status](https://github.com/lizmat/DateTime-strftime/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/DateTime-strftime/actions)

NAME
====

DateTime::strftime - provide strftime() formatting for DateTime objects

SYNOPSIS
========

```raku
use DateTime::strftime;

say strftime(DateTime.now, '%c');  # default": EN
# Sun Jan 19 13:19:02 +0100 2025

say strftime(DateTime.now, '%c', "NL");
# zon 19 jan 13:19:02 +0100 2025
```

DESCRIPTION
===========

The `DateTime::strftime` distribution provides a `strftime` subroutine that takes a `DateTime` object, a [`strftime`](https://linux.die.net/man/3/strftime) format string (or its `:text:` equivalent), and an optional locale indicator (which defaults to the dynamic variable `$*LOCALE-DATES` or `"EN"`).

It returns the representation of the `DateTime` object according to that format and locale.

FORMAT SPECIFICATION
====================

The supported formats are a (large) subset of `strftime`. The `E` and `O` modifiers are **not** supported.

Since the `strftime` format codes are rather cryptic (although very widely in use), one can also use an alternate `:text:` format. So instead of the rather cryptic `"%c"`, one can also use `":datetime:"`.

<table class="pod-table">
<thead><tr>
<th>Code</th> <th>:text:</th> <th>Value</th>
</tr></thead>
<tbody>
<tr> <td>%a</td> <td>wkdname</td> <td>abbreviated weekday name</td> </tr> <tr> <td>%A</td> <td>weekdayname</td> <td>full weekday name</td> </tr> <tr> <td>%b</td> <td>mnthname</td> <td>abbreviated month name</td> </tr> <tr> <td>%B</td> <td>monthname</td> <td>full month name</td> </tr> <tr> <td>%c</td> <td>datetime</td> <td>preferred date/time representation</td> </tr> <tr> <td>%C</td> <td>century</td> <td>century number (year div 100)</td> </tr> <tr> <td>%d</td> <td>0day</td> <td>day of month (&quot;01&quot; .. &quot;31&quot;)</td> </tr> <tr> <td>%D</td> <td>usadate</td> <td>short for: %m/%d/%y</td> </tr> <tr> <td>%e</td> <td>day</td> <td>day of month (&quot; 1&quot; .. &quot;31&quot;)</td> </tr> <tr> <td>%f</td> <td></td> <td>same as %M</td> </tr> <tr> <td>%F</td> <td>isodate</td> <td>short for: %Y/%m/%d</td> </tr> <tr> <td>%g</td> <td>weekYY</td> <td>YY of this week (&quot;00&quot; .. &quot;99&quot;)</td> </tr> <tr> <td>%G</td> <td>weekYYYY</td> <td>full year of this week</td> </tr> <tr> <td>%h</td> <td></td> <td>same as %b</td> </tr> <tr> <td>%H</td> <td>0hour</td> <td>24-hour hour (&quot;00&quot; .. &quot;23&quot;)</td> </tr> <tr> <td>%I</td> <td>0amhour</td> <td>12-hour hour (&quot;01&quot; .. &quot;12&quot;)</td> </tr> <tr> <td>%j</td> <td>yearday</td> <td>day of the year (&quot;001&quot; .. &quot;366&quot;)</td> </tr> <tr> <td>%k</td> <td>hour</td> <td>24-hour hour (&quot; 1&quot; .. &quot;23&quot;)</td> </tr> <tr> <td>%l</td> <td>amhour</td> <td>12-hour hour (&quot; 1&quot; .. &quot;12&quot;)</td> </tr> <tr> <td>%L</td> <td></td> <td>same as %Y</td> </tr> <tr> <td>%m</td> <td>month</td> <td>month (&quot;01&quot; .. &quot;12&quot;)</td> </tr> <tr> <td>%M</td> <td>minute</td> <td>minute (&quot;00&quot; .. &quot;59&quot;)</td> </tr> <tr> <td>%n</td> <td>newline</td> <td>&quot;\n&quot;</td> </tr> <tr> <td>%p</td> <td>AMPM</td> <td>&quot;AM&quot; | &quot;PM&quot;</td> </tr> <tr> <td>%P</td> <td>ampm</td> <td>&quot;am&quot; | &quot;pm&quot;</td> </tr> <tr> <td>%r</td> <td>amtime</td> <td>short for: %I:%M:%S %p</td> </tr> <tr> <td>%R</td> <td>HHMM</td> <td>short for: %H:%M</td> </tr> <tr> <td>%s</td> <td>epoch</td> <td>seconds since epoch (midnight 1970-01-01 UTC)</td> </tr> <tr> <td>%S</td> <td>second</td> <td>second (&quot;00&quot; .. &quot;59&quot;)</td> </tr> <tr> <td>%t</td> <td>tab</td> <td>&quot;\t&quot;</td> </tr> <tr> <td>%T</td> <td>HHMMSS</td> <td>short for: %H:%M:%S</td> </tr> <tr> <td>%u</td> <td>weekday</td> <td>weekday (1 .. 7)</td> </tr> <tr> <td>%U</td> <td>weekSun</td> <td>week number (first Sunday) (&quot;00&quot; .. &quot;53&quot;)</td> </tr> <tr> <td>%v</td> <td>DD-MON-YYYY</td> <td>short for: %e-%b-%Y</td> </tr> <tr> <td>%V</td> <td>weekISO</td> <td>week number (ISO 8601) (&quot;00&quot; .. &quot;53&quot;)</td> </tr> <tr> <td>%w</td> <td>0weekday</td> <td>weekday (0 .. 6)</td> </tr> <tr> <td>%W</td> <td>weekMon</td> <td>week number (first Monday) (&quot;00&quot; .. &quot;53&quot;)</td> </tr> <tr> <td>%x</td> <td>date</td> <td>preferred date representation</td> </tr> <tr> <td>%X</td> <td>time</td> <td>preferred time representation</td> </tr> <tr> <td>%y</td> <td>YY</td> <td>year without century (&quot;00&quot; .. &quot;99&quot;)</td> </tr> <tr> <td>%Y</td> <td>year</td> <td>year (yyyy)</td> </tr> <tr> <td>%z</td> <td>tzoffset</td> <td>numeric timezone (±HHMM)</td> </tr> <tr> <td>%Z</td> <td>timezone</td> <td>timezone (no name: %z)</td> </tr> <tr> <td>%+</td> <td>unixdate</td> <td>short for: %a %b %e %T %Z %G</td> </tr> <tr> <td>%%</td> <td>percent</td> <td>&quot;%&quot;</td> </tr>
</tbody>
</table>

Please note that one probably shouldn't use the `%g` and `%y` formats for anything that is persistent. Data and programs stay around longer then anybody expects, and we don't want another [Y2K](https://en.wikipedia.org/wiki/Year_2000_problem) problem, especially in a 100-year programming language!

DEFAULT LOCALIZATION
====================

```raku
my $*LOCALE-DATES = "NL";
say strftime($dt, ':weekdayname:');        # zondag
say strftime($dt, ':weekdayname:', "EN");  # Sunday
```

The `$*LOCALE-DATES` dynamic variable can be set with the string of the desired localization, or with an instantiated `Locale::Dates` object. It will then affect any call to `strftime` that does **not** have an explicit localization specified.

LEXICAL REFINEMENT
==================

```raku
use DateTime::strftime :refine;

say DateTime.now.strftime('%c');  # default": EN
# Sun Jan 19 13:19:02 +0100 2025

say DateTime.now.strftime(':datetime:', "NL");
# zon 19 jan 13:19:02 +0100 2025
```

You can also use `DateTime::strftime` with the `:refine` parameter. This will add a `strftime` method to the `DateTime` class in the lexical scope in which the `use` statement is located. This allows one to not to have to change existing code using the `DateTime` class, while still having the added functionality of a `DateTime.strftime` method.

OTHER SOFTWARE
==============

See also Jean Forget's [`Date::Calendar::Strftime`](https://raku.land/zef:jforget/Date::Calendar::Strftime) and [`Date::Calendar::Gregorian`](https://raku.land/zef:jforget/Date::Calendar::Gregorian).

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/DateTime-strftime . Comments and Pull Requests are welcome.

If you like this module, or what I'm doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

