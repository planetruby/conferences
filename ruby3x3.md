{% comment %}

Note, this is the source code version, see the live web page @ [`planetruby.github.io/calendar/ruby3x3` »](https://planetruby.github.io/calendar/ruby3x3).

{% endcomment %}



# Ruby 3x3 - Ruby 3 Will Be 3 Times Faster - What's News?


### Q: What's 3x3?

_3x3 => Ruby 3 will be 3 times faster in 2020_ 

Ruby 3 - the next major update of ruby (planed for 2020) will be 3 times (3x) faster than Ruby 2.

Note: The baseline for Ruby3x3 is 2.0 so all the improvements in 2.x will count toward the 3x goal.


### Q: What's OptCarrot? [:octocat:](https://github.com/mame/optcarrot)

_A Nintendo Entertainment System (NES) emulator written in Ruby - running with 60 frames per seconds (fps) in Ruby 3 in 2020_

An "enjoyable" benchmark for rubies to drive "Ruby 3x3: Ruby 3 will be 3 times faster".

The benchmark is a Nintendo Entertainment System (NES) emulator that works at 20 frames per seconds (fps) in Ruby 2.0. 
An original NES works at 60 fps. If Ruby 3x3 succeeds, we can enjoy NES games with ruby!

NOTE: We do not aim to create a practical NES emulator. 
There are many great emulators available today. 
We recommend using another emulator if you want to play a game.

**Benchmark example**

![](https://raw.githubusercontent.com/mame/optcarrot/master/doc/benchmark-summary.png)

See [Rubies Benchmark with Optcarrot](https://github.com/mame/optcarrot/blob/master/doc/benchmark.md) for the measurement condition and some more charts.


### Major News

- 2017/Dec - [MJIT infrastructure accepted into Ruby 2.6](https://github.com/ruby/ruby/pull/1782) - MJIT infrastructure means: JIT worker thread, profiler, gcc/clang compiler support, loading function from shared object file, some hooks to ensure JIT does not cause SEGV, etc...

See the [#Ruby3x3](https://twitter.com/hashtag/Ruby3x3) hashtag on twitter for the latest Ruby 3x3 news bytes.



## Articles

An awesome collection about ruby 3x3 news, benchmarks and more:

{% include ruby3x3.html %}
