fs = require 'fs'
data = fs.readFileSync 'dumps/mac_setup_device', encoding: 'utf-8'

for packet,i in data.split 'SETUP: 5.0'
  if i > 0
    console.log()
    for line in packet.split '\n'
      [type,contents] = line.split ':'
      if type is 'DATA0'
        [bmRequestType, bRequest, wValueL, wValueH, wIndexL, wIndexH, wLengthL, wLengthH, _, _] = contents.split(' ')[1..]
      if type is 'DATA1'
        data = contents
        break
    buffer = contents.split(' ')
    buffer = buffer[1..buffer.length-3]
    console.log "unsigned char send[#{buffer.length}];"
    for byte,i in buffer
      console.log "send[#{i}] = 0x#{buffer[i]};"
    console.log "libusb_control_transfer(devh, 0x#{bmRequestType}, 0x#{bRequest}, 0x#{wValueH}#{wValueL}, 0x#{wIndexH}#{wIndexL}, send, #{buffer.length}, 0);"


  ###
  [type,contents] = line.split(':')
  console.log type, contents
  if type is 'DATA0'
    tree
    ###
