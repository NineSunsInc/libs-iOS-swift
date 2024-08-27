//
//  Utils.swift
//  NineSunsSDK
//
//
import Foundation

func extractVarintPrefixed(_ o: inout [String: Data]) -> Data {
  guard let data = o["bs"] else {
    fatalError("Data not found in dictionary")
  }
  
  let chunkLen = decodeBytes(data)
  let chunkLenLen = encodingLength(of: chunkLen)
  
  let startIndex = data.index(data.startIndex, offsetBy: chunkLenLen)
  let endIndex = data.index(startIndex, offsetBy: chunkLen)
  let chunk = data[startIndex..<endIndex]
  
  o["bs"] = data[endIndex...]
  
  return chunk
}

func decodeVarint(data: Data) -> Int? {
  var value = 0
  var shift = 0
  for byte in data {
    value |= (Int(byte & 0x7F) << shift)
    if (byte & 0x80) == 0 {
      return value
    }
    shift += 7
  }
  return nil
}

func concatUint8Arrays(_ arrays: Data...) -> Data {
  var result = Data()
  for array in arrays {
    result.append(array)
  }
  return result
}

func varintPrefixed(_ data: Data) -> Data {
  let lengthEncoded = encodeVarint(data.count)
  return concatUint8Arrays(lengthEncoded, data)
}

func encodeVarint(_ value: Int) -> Data {
  var value = value
  var result = Data()
  while value >= 0x80 {
    result.append(UInt8(value & 0x7F | 0x80))
    value >>= 7
  }
  result.append(UInt8(value))
  return result
}

func encodingLength(of value: Int) -> Int {
  let N1 = 1 << 7
  let N2 = 1 << 14
  let N3 = 1 << 21
  let N4 = 1 << 28
  let N5 = 1 << 35
  let N6 = 1 << 42
  let N7 = 1 << 49
  let N8 = 1 << 56
  let N9 = 1 << 63
  
  if value < N1 {
    return 1
  } else if value < N2 {
    return 2
  } else if value < N3 {
    return 3
  } else if value < N4 {
    return 4
  } else if value < N5 {
    return 5
  } else if value < N6 {
    return 6
  } else if value < N7 {
    return 7
  } else if value < N8 {
    return 8
  } else if value < N9 {
    return 9
  } else {
    return 10
  }
}

func utf8StringToBytes(_ string: String) -> Data {
  return string.data(using: .utf8) ?? Data()
}

func utf8BytesToString(_ data: Data) -> String {
  return String(data: data, encoding: .utf8) ?? ""
}

func decodeBase64Message(_ message: String) -> Data? {
  guard let decodedData = Data(base64Encoded: message) else {
    print("Failed to decode base64 message")
    return nil
  }
  return decodedData
}

// Varint

func decodeStream(_ stream: InputStream) -> Int {
  var shift = 0
  var result = 0
  while true {
    let i = _readOne(stream)
    result |= (i & 0x7f) << shift
    shift += 7
    if (i & 0x80) == 0 {
      break
    }
  }
  return result
}

func decodeBytes(_ buf: Data) -> Int {
  let stream = InputStream(data: buf)
  stream.open()
  defer {
    stream.close()
  }
  return decodeStream(stream)
}

private func _readOne(_ stream: InputStream) -> Int {
  var buffer = [UInt8](repeating: 0, count: 1)
  let bytesRead = stream.read(&buffer, maxLength: 1)
  guard bytesRead > 0 else {
    fatalError("Unexpected EOF while reading bytes")
  }
  return Int(buffer[0])
}
