# external-display

# Quick Start!

1. Connect from the Panel INPUT to Output H on the control board
2. Connect ethernet to the control board's ethernet port
3. Connect power to the control board

As soon as the DCDC converter comes up, you'll see the blue LED by the ethernet jack turn on, this indicates power.

Within a few seconds, the LEDs on the ethernet port should come alive.

Within probably 30 seconds, the system should have a connection to AWS

The default config file defines two fonts (0 and 1).    I did not put a lot of effort into these fonts, so they're not necessarily ideal for testing.

Font 0 is a 5x8 font, Font 1 is an 8x8 font (but I believe the glyphs are flipped LR).

So, let's print some text in the 5x8 font:

To the `sym/ica/exd/draw/BCDDC2C8F3B7` endpoint, send the following JSON:

```json
{
      "draw_text": {
 			 "content_id" : 1,
 			 "display_id" : 0,
			 "font_id" : 0,
 			 "x" : 0,
 			 "y" : 0,
 			 "velocity_x" : 0,
 			 "velocity_y" : 0,
 			 "color" : [10,10,0],
			 "text" : "HELLO"
 		 }
  }
```

To clear this, you can send this JSON to the `sym/ica/exd/displaycontent/BCDDC2C8F3B7` endpoint:

```json
{
    "clear_display": [0]
}
```

### A few key concepts

1. A "display" always consists of a 96px x 16px framebuffer
2. Objects that extend off the edge of this framebuffer "wrap around" pacman style— so column 97 is effectively column 1 again.  Same vertically.  
3. A "panel" is a 32px x 16px portion of this display — as currently configured output H is the leftmost of these panels.   So pixel 0,0 is the top left corner of this panel.    Text that extends off the right side of this panel will not wrap back onto the panel, although text that extends below will.  
4. I don't have a good solution for scrolling text that's wider than 96 pixels.   ~~It's possible we need to add a flag that says to not wrap certain text around, as currently implemented it'll just keep wrapping around and around on top of itself.   Let me know.~~ We added a wrapping flag!
5. The velocity parameter is in "native units" which is pixels per microsecond.   0.0000128 is a good starting value (that's the full width in 10 seconds).


# Architecture

## Control Board

This is a PCB that contains power management, ethernet connectivity, the Miranda Core Module and connections for the (8) pixel outputs.  

### Power Management

CB has a 5mm pluggable screw terminal (Phoenix 5452046).  The mating connector is Phoenix 1756256.

This feeds into a p-channel FET for polarity protection, then through a .0033ohm 1% resistor for current sensing.

An INA219 is used for input voltage and current sensing, on the i2c bus.  

The raw 9V-36V feeds to the RECOM RPA60-24055SFW/N, which provides a +5V rail at 12A.

Primarily this is fed through very large traces to the LED output connections, but it also feeds a 3.3V LDO to provide 3.3V for the Miranda Core.

To support the INA219, the 12VDC and the 5VDC grounds are tied together.  

### FAN Header

Fan header MOSFET is connected to a PWM-able output pin on the attiny on the Miranda Core.  No firmware is currently written to support this, but the Miranda Core has an onboard NTC also connected to the attiny, so a simple proportional controller could be easily written (even standalone without ESP32 involvement).

### LED Interface

The current version of the control board interfaces the Miranda Core to an STM32F104 that is used to drive the LEDs.   

The Miranda Core is connected via SPI to the STM32F104.

The STM32F104 is then connected to the Toshiba 74VHCT541AFT(BE) Buffer, which level shifts from 3.3V to 5V for output.   The buffer is powered off the same 5VDC rail provided by the DCDC converter.

It is notable that the current STM32F104 firmware outputs a single 96x16 framebuffer to output H.   Outputs A-G are not active.

### Ethernet

The board provides a 10/100 ethernet connection via an RJ45 jack.   Green LED indicates 100MBit connection, Orange LED indicates network traffic.

### Miranda Core

This is a 4-layer board that breaks out the ESP32, an ATTINY841, and a LAN8720A PHY into a module that can be mounted to cheap 2-layer boards.  

### LED Connectors

There are (8) LED connectors labeled A-H.  These are Molex Mini50 connectors (Molex 34793-0040), the mating connector is Molex 34791-0040 with 560023-0550 contacts.

The connector provides 5VDC, Ground and the control signal.   

Pin 1 is ground, pins 2 and 3 are control, Pin 4 is +5VDC.   The pinout on the other end is the same.  Only one control signal needs to be connected.

## LED Matrix

### Overview

An LED Matrix panel consists of 512 SK6805 LEDs arranged on a 4mm grid, in a zig-zag pattern.

### Connections

The matrix has an input and an output connector.  The pinout is the same as the control board.

These are Molex Mini50 connectors (Molex 34793-0040), the mating connector is Molex 34791-0040 with 560023-0550 contacts.

The connector provides 5VDC, Ground and the control signal.   

Pin 1 is ground, pins 2 and 3 are control, Pin 4 is +5VDC.   The pinout on the other end is the same.  Only one control signal needs to be connected.  

The output takes the control signal off the last LED of the panel.  

There is significant amounts of copper in the +5VDC and GND rails, so I would expect that the board will generally be able to pass 4A of current (the limit for the mini50 connector) downstream to the next panel.   Which is to say, I think the connectors will be the limiting factor in daisy-chaining panels.  

### Mounting Holes

The panels designed to be mounted together along their short sides.  They have #4/M3 mounting holes on 42.6667mm spacing.   This (rather odd) spacing allows you to build rails with holes on 42.67mm spacing and mount panels to it, it will enforce the 4mm pixel spacing, even across panel edges.


## AWS Credential Loading

HTTP endpoints have been added for the credentials and hostname.  The root-ca is still encoded into the firmware and cannot be separately loaded.   You do not need to NULL-terminate the files, as-provided by AWS is just fine.

```bash
curl -X POST --data-binary @83766affe2-certificate.pem.crt http://192.168.0.204/api/v1/upload/cert
curl -X POST --data-binary @83766affe2-private.pem.key http://192.168.0.204/api/v1/upload/key
curl -X POST -d "a3rbw0kswcb7mq-ats.iot.us-east-1.amazonaws.com" http://192.168.0.204/api/v1/set/hostname
```

To provide some more specificity, here are the endpoints in detail:

### /api/v1/upload/cert

This takes the certificate, in PEM format and loads it into flash, including the required NULL byte that the system needs to discover the end of the certificate.   It takes the bytes as an octet-stream as the contents of a POST request.   The curl commandline is this:

```bash
curl -X POST -d @83766affe2-certificate.pem.crt http://192.168.0.204/api/v1/upload/cert
```

Where "83766affe2-certificate.pem.crt" is the filename of the certificate.

### /api/v1/upload/key

This takes the key, in PEM format and loads it into flash, including the required NULL byte that the system needs to discover the end of the certificate.   It takes the bytes as an octet-stream and as the contents of a POST request.  The curl commandline is this:

```bash
curl -X POST -d @83766affe2-private.pem.key http://192.168.0.204/api/v1/upload/key
```

Again where "83766affe2-private.pem.key" is the name of the keyfile.

### /api/v1/set/hostname

This takes the AWS IOT endpoint hostname as a string and saves it to NVS.   It can be loaded from a file, or just directly on the commandline by omitting the @ symbol from the curl command.  Again, it's just a bytestream over POST:

```bash
curl -X POST -d "a3rbw0kswcb7mq-ats.iot.us-east-1.amazonaws.com" http://192.168.0.204/api/v1/set/hostname
```

# AWS API

The device subscribes to the following topics:

- sym/ica/exd/command/{MAC}
- sym/ica/exd/admin/{MAC}
- sym/ica/exd/display/{MAC}
- sym/ica/exd/displaycontent/{MAC}
- sym/ica/exd/draw/{MAC}
- sym/ica/exd/update/{MAC}
- sym/ica/exd/wrap/{MAC}  (New!)
- sym/ica/exd/sideload/{MAC} (New!)
- sym/ica/exd/info/content/{MAC} (currently unimplemented)
- sym/ica/exd/info/diag/{MAC} (currently unimplemented)

MAC is in the format BCDDC2C8F3B7 and is the device's ethernet MAC address.

### sym/ica/exd/command/{MAC}

This endpoint determines if the panel should process any commands.  It currently defaults to 1.

To enable processing of commands:

```json
{
	"command" : 1
}
```

To disable processing of commands:

```json
{
"command" : 0
}
```

### sym/ica/exd/admin/{MAC}

Administrative commands.  

Available commands:

- 1 = Reboot
- 2 = Reset
- 3 = Upgrade (update firmware, requires URL)
- 4 = Ping (currently unimplemented)
- 5 = Update config file (requires URL)

Reboot:

```json
{
	"state" : 1
}
```

Reset (this erases the first block of the configuration file):

```json
{
	"state" : 2
}
```

Upgrade:

(URL **must** be https)

```json
{
	"state" : 3,
	"url" : "https://storage.googleapis.com/cdn.benpeoples.com/firmware/miranda_core.bin"
}
```

Update:

```json
{
	"state" : 5,
	"url" : "https://storage.googleapis.com/cdn.benpeoples.com/config/config.bin"
}
```

### sym/ica/exd/display/{MAC}

Turns displays on and off, always accepts an array of 1 or more displays to affect.   Always turns displays off before it turns them on.

```json
{
"turn_off_display": [0,1,2,3],
"turn_on_display": [0,1,2,3]
}

{
"turn_on_display": [0,1,2,3]
}

{
"turn_on_display": [0]
}

{
"turn_on_display": [7]
}
```

### sym/ica/exd/displaycontent/{MAC}

Controls display content objects.  All keys take only arrays of 1 or more content_ids or display_ids:

Clear display:

```json
{
    "clear_display": [0,1,2,3]
}
```

Erase item:

```json
{
    "erase_item" : [0,1,2,3,4,5,6,7,8]
}
```

Content_id's are user provided.  Erase_item will find the first (usually the newest) ID in the case of duplicates.   Calling erase_item multiple times should delete the object multiple times.

### sym/ica/exd/draw/{MAC}

Draw new objects, types include rectangles, sprites, or text.

```json
{
     "draw_rec": {
			 "content_id" : 1,
			 "display_id" : 0,
			 "x" : 0,
			 "y" : 0,
			 "size_x" : 5,
			 "size_y" : 5,
			 "velocity_x" : 0,
			 "velocity_y" : 0,
			 "color" : [255,0,0]
		 }
 }
```

- content_id : this is a user-provided id that identifies this content.  No error if it's not unique, but it may be difficult to delete or update if it's not unique.  It's stored as a 32-bit unsigned integer.
- display_id: which logical display to put this object on.
- x : the x coordinate of the top left corner of the text, rectangle, or sprite
- y : the y coordinate of the top left corner of the text, rectangle, or sprite
- size_x: for rectangles, the size of the rectangle in x.
- size_y: for rectangles, the size of the rectangle in y.
- color: an array of three integers providing an 8-bit R, G, B, color.
- velocity_x/velocity_y: these define the speed of the object in each axis.   The speed is in pixels per microsecond.  So if you want an object to rotate across the display in 10 seconds, which is 128 pixels in 10^7 microseconds, or 0.0000128.   Animations just wrap the edges.

Text:

```json
{
      "draw_text": {
 			 "content_id" : 1,
 			 "display_id" : 0,
			 "font_id" : 0,
 			 "x" : 0,
 			 "y" : 0,
 			 "velocity_x" : 0,
 			 "velocity_y" : 0,
 			 "color" : [255,0,0],
			 "text" : "lorem ipsum"
 		 }
  }
```

"font_id" here defines which font (index position in the array) to use.

Sprite:

```json
{
       "draw_sprite": {
  			 "content_id" : 1,
  			 "display_id" : 0,
 			 	"sprite_id" : 1,
  			 "x" : 1,
  			 "y" : 1,
  			 "velocity_x" : 2,
  			 "velocity_y" : 2,
  			 "color" : [255,0,0]
  		 }
   }
```

"sprite_id" defines which sprite to display.

### sym/ica/exd/update/{MAC}

This updates objects.   This is currently implemented as a replacement: that is, the content_id indicated is fully replaced with the new content.  Draw order is maintained. 

The object is otherwise identical with the draw command:

```json
{
     "update_rec": {
			 "content_id" : 1,
			 "display_id" : 0,
			 "x" : 2,
			 "y" : 1,
			 "size_x" : 5,
			 "size_y" : 5,
			 "velocity_x" : 0,
			 "velocity_y" : 0,
			 "color" : [255,0,0]
		 }
 }
Other keys are "update_text" and "update_sprite"
```

### sym/ica/exd/wrap/{MAC}

An additional endpoint to control the wrapping flag.   If wrapping is on, text will wrap around (effectively, pixel positions are the modulo of the pixel position and the dimensions of the framebuffer), so pixel position 100 is actually 100 % 96, or 4.   

```json
{
     "wrap": 0
}
```

The above document disables wrapping (pixels outside the drawable area are simply ignored)

```json
{
     "wrap": 1
}
```

The above document enables wrapping.

### sym/ica/exd/sideload/{MAC}

This endpoint allows you to sideload a sprite onto the display, overriding whatever is currently on the display and without a reboot process. 

```json
{ 
	"url": "http://10.1.108.144/test2.bin",
	"x" : 5,
	"y" : 5,
	"color" : [255, 0, 0]
}
```

This loads the sprite located at the given url, displays it at the coordinates in the given color.   

The sprite is displayed until a reboot, another sprite is loaded, or the sideload is released:

```json
{
     "release": 1
}
```

When released, the display goes back into displaying whatever content arrays were previously displayed.

The format of the binary sprite is one byte of height, one byte of width and then up to 1536 bytes of greyscale (0-255).    The layout is horizontal rows.    For instance:

```
05 05 

FF FF FF FF FF
FF 00 00 00 FF
FF 00 00 00 FF
FF 00 00 00 FF
FF 00 00 00 FF
FF FF FF FF FF
```

This defines a 5 pixel by 5 pixel square, it would be encoded as a bytestream thus:

```
05 05 FF FF FF FF FF FF 00 00 00 FF FF 00 00 00 FF
FF 00 00 00 FF FF 00 00 00 FF FF FF FF FF FF
```

This is perhaps an ambiguous example.   To take an example that is less so, consider this:

```
05 03

FF FF FF FF FF
00 FF 00 FF 00
00 FF 00 FF 00
```

This draws a 5 pixel wide, 3 pixel tall table.   It would be encoded like this:

```
05 03 FF FF FF FF FF 00 FF 00 FF 00 00 FF 00 FF 00
```

You can, of course, make the sprite up to 96 pixels wide and 16 pixels tall and use any values between 0 and 255 (0x00 and 0xFF) to make up the pixels.  

### sym/ica/exd/info/content/{MAC}

Not yet implemented!  Primarily a talk-back command to dump content arrays back to the server.

### sym/ica/exd/info/diag/{MAC}

Not yet implemented!  A talk-back command to provide diagnostic information to the server
