fs = require 'fs'
data = fs.readFileSync 'dumps/mac_setup_device', encoding: 'utf-8'

for packet,i in data.split 'SETUP: 5.0'
  if i > 0
    for line in packet.split '\n'
      [type,contents] = line.split ':'
      if type is 'DATA0'
        [bmRequestType, bRequest, wValueL, wValueH, wIndexL, wIndexH, wLengthL, wLengthH, _, _] = contents.split(' ')[1..]
      if type is 'DATA1'
        data = contents
        break
    buffer = contents.split(' ')
    buffer = buffer[1..buffer.length-3]
    n = String('0000'+i).slice(-4)
    console.log "#{n}: #{bmRequestType} #{bRequest} #{wValueH}#{wValueL} #{wIndexH}#{wIndexL}        #{buffer.join '' }"
