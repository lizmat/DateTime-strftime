use Locale::Dates:ver<0.0.4+>:auth<zef:lizmat>;

# Fast sprintf(%02i) and sprintf(%2i)
my sub percent02i($value) { $value < 10 ?? "0$value" !! $value.Str }
my sub percent2i ($value) { $value < 10 ?? " $value" !! $value.Str }

# Convert hour to 12 hour format, with given prefix if < 10
my sub ampm-hour($dt, $prefix) {
    my $hour = $dt.hour;
    $hour -= 12 if $hour > 12;
    $hour < 10 ?? $prefix ~ $hour !! $hour
}

# Convert timezone from seconds to ±HHMM
my sub timezone(Int() $timezone) {
    my str $tz =
      $timezone.abs.polymod(60,60).skip.reverse.map(&percent02i).join;
    $timezone < 0 ?? "-$tz" !! "+$tz"
}

# The dispatch mapping, should really be a constant, but that causes
# some lookup issues, specifically of $_, at runtime.  So we run it
# here once at startup
my %dispatch is Map = 
  "%a" => -> $dt, $ld { $ld.abbreviated-weekdays[$dt.day-of-week] },
  "%A" => -> $dt, $ld { $ld.weekdays[$dt.day-of-week] },
  "%b" => -> $dt, $ld { $ld.abbreviated-months[$dt.month] },
  "%B" => -> $dt, $ld { $ld.months[$dt.month] },
  "%c" => -> $dt, $ld { strftime($dt, $ld.date-time-representation, $ld) },
  "%C" => -> $dt, $   { percent2i($dt.year div 100) },
  "%d" => -> $dt, $   { percent02i($dt.day) },
  "%D" => -> $dt, $   { $dt.dd-mm-yyyy("/") },
  "%e" => -> $dt, $   { percent2i($dt.day) },
  "%f" => -> $dt, $   { percent02i($dt.month) },
  "%F" => -> $dt, $   { $dt.yyyy-mm-dd("/") },
  "%g" => -> $dt, $   { $dt.week-year.substr(*-2) },
  "%G" => -> $dt, $   { $dt.week-year },
  "%h" => -> $dt, $ld { strftime($dt, '%b', $ld) },
  "%H" => -> $dt, $   { percent02i($dt.hour) },
  "%I" => -> $dt, $   { ampm-hour($dt, "0") },
  "%j" => -> $dt, $   { $dt.day-of-year.fmt('%03d') },
  "%k" => -> $dt, $   { percent2i($dt.hour) },
  "%l" => -> $dt, $   { ampm-hour($dt, " ") },
  "%L" => -> $dt, $   { $dt.year },
  "%m" => -> $dt, $   { percent02i($dt.month) },
  "%M" => -> $dt, $   { percent02i($dt.minute) },
  "%n" => -> $,   $   { "\n" },
  "%p" => -> $dt, $ld { $dt.hour > 11 ?? $ld.PM !! $ld.AM },
  "%P" => -> $dt, $ld { $dt.hour > 11 ?? $ld.pm !! $ld.am },
  "%r" => -> $dt, $ld { strftime($dt, '%I:%M:%S %p', $ld) },
  "%R" => -> $dt, $   { $dt.hh-mm-ss.substr(0,5) },
  "%s" => -> $dt, $   { $dt.Instant.to-posix.head.Int },
  "%S" => -> $dt, $   { percent02i($dt.second.Int) },
  "%t" => -> $,   $   { "\t" },
  "%T" => -> $dt, $   { $dt.hh-mm-ss },
  "%u" => -> $dt, $   { $dt.day-of-week },
  "%U" => -> $dt, $   { percent02i($dt.week-number) }, # first Sunday ???
  "%v" => -> $dt, $ld { strftime($dt, '%e-%b-%Y', $ld) },
  "%V" => -> $dt, $   {
      percent02i($dt.week-number + ($dt.week-year != $dt.year)) # ISO 8601
  },
  "%w" => -> $dt, $   { $dt.day-of-week mod 7 },
  "%W" => -> $dt, $   { percent02i($dt.week-number) }, # first Monday ???
  "%x" => -> $dt, $ld { strftime($dt, $ld.date-representation, $ld) },
  "%X" => -> $dt, $ld { strftime($dt, $ld.time-representation, $ld) },
  "%y" => -> $dt, $   { $dt.year.substr(*-2) },
  "%Y" => -> $dt, $   { $dt.year },
  "%z" => -> $dt, $   { timezone(+$dt.timezone) },
  "%Z" => -> $dt, $   {
      my $tz = $dt.timezone; $tz ~~ Int ?? timezone($tz) !! $tz
  },
  "%+" => -> $dt, $ld { strftime($dt, '%a %b %e %T %Z %G', $ld) },
  "%%" => -> $  , $   { "%" },
;

# The actual handler
my sub strftime(
  DateTime:D $dt,
       Str:D $format,
             $ld? is copy,
--> Str:D) is export(:DEFAULT, :refine) {

    if $ld {
        $ld = Locale::Dates($ld) if $ld ~~ Str;
    }
    else {
        $ld = Locale::Dates($*LOCALE-DATES // "EN");
    }

    $format.trans: / '%' <[\w+%]> / => {
        (%dispatch{$_} // -> $,$ { $_ })($dt, $ld)
    }
}

my class DateTime is DateTime { }
BEGIN DateTime.^add_method: "strftime", &strftime;

BEGIN EXPORT::refine::<DateTime> := DateTime;

# vim: expandtab shiftwidth=4
