## openvizsla2c

Take an openvizsla dump and turn it into c code

very very janky. this should not be used by anyone.

## Usage

`npm install` to install dependencies.

`npm start [path-to-file]` to run the main conversion script, which will output C code.

`npm test [path-to-file]` to dump in a more pattern-matching for humans friendly format.

The hope is that the test will help us understand the protocol well enough to
deprecate this entire terrible utility.

## Assumptions

There are a lot of assumptions in these scripts:

  1. Every packet will have one DATA1 payload sent via OUT
  2. DATA1 OUT payload will be resent until an ACK is recieved
  3. DATA1 IN payload always is 00 00

From these assumptions, the process is very simple:

  1. Use SETUP as a delimeter of packets
  2. Ignore everything until the first DATA0 (payload of SETUP)
  3. Ignore everything until the first DATA1 (payload of OUT)

There are probably off-by-one errors all over the place
