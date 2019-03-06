# Mapping uncertainty

Here's some code for creating risk maps from a Bayesian model that include some reference of uncertainty.

Uncertainty is included by plotting HOPs (hypothetical outcome plots - i.e. a plot per posterior sample) and
by also including a 'cloud of uncertainty' which greys out where we're most uncertain, and shines through we're
we are least uncertain.

It can then be animated with `gganimate` - see animation.webm for an example file.
