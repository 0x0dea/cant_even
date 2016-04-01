# cant_even

Once loaded, **cant_even** makes it considerably more difficult to introduce dis[parity](https://en.wikipedia.org/wiki/Parity_(mathematics)) into your program.

### "Usage"

```ruby
17 + 25
# => 42

require 'cant_even'

17 + 25
# => Do you even return value? No, `42', you don't. (CantEven::ParityError)

19 * 84
# => argument `84' has insufficient oddity.

2016 / 12
# => `2016' is an inappropriately even receiver.
```
