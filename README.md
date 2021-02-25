# README

Rails backend written in 2.5.8 to be deployed with Jets Afterburner... no deployment Database included

Some notes on the challenge:

The method for terminating (timestamping disabled_at) is a PATCH request. May have wanted that as a POST or a PUTS instead.

Also the phonelib gem has an error in it, it hated my phone number specifically (kept formatting it into an India country code). So there may be some silly extra logic for that.  I will probably raise an issue on github after I go through their gem some more.
