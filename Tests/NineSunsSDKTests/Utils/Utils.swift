//
//  Utils.swift
//  ninesunsencrypted
//
//

import Foundation

// Function to decode JSON data
func decodeJSONData<T: Codable>(_ type: T.Type, from data: Data) -> T? {
  let decoder = JSONDecoder()
  do {
    let decodedObject = try decoder.decode(T.self, from: data)
    return decodedObject
  } catch {
    print("Error decoding JSON: \(error)")
    return nil
  }
}

func getTestData() -> [DataModel] {
  let testData = """
[
  {
    "rawData": "The extraordinary complexity of the universe never ceases to inspire a profound sense of wonder and curiosity in those who seek to understand its mysteries.",
    "publicKey": "7N8zBmO7B2Z16uktpj2900w/RBBJO6L80rpqgaQIZzw=",
    "privateKey": "BYoNcbS0j/GBDGLysOzZVWtExT6emzORmIksq1fUXWE=",
    "encryptedData": "3LD08fQ5wW+3Mcx1v3Ua61jH3AERuZMdB57Q0XQNHJp2PL5WpGSwC3jH1fZhPKEflw3Kymgxu/2y10WfQ/xj8Bz5uowCzVPuOUT2OLvCqnVEimYFBpUOH01dCKBQOP1f1k2gm3duZwQmyQYUK9LRg2fDqGSoGqSVIxpPLO3LaSaVxg1tuC71ma0jpQBk7kmIKQTmvRSJkxZ+fKmSyJAksese4tRl1p/1cuZ6kan+r5UjFzCzAxdxw8QkU6TX8+TwUEI7PQ=="
  },
  {
    "rawData": "In a world where technological advancements seem to occur at an exponential rate, it is crucial to remain vigilant about the ethical implications of such rapid progress.",
    "publicKey": "kvsQYngo0NpsJxPPXBuxlVElOAUVr+vVjC+DFfiUNXg=",
    "privateKey": "N83mYNfPzYcZtiHkXffgL20PvfPYk6Ccd/ZSDd/H/Yg=",
    "encryptedData": "TGpQVBo+TYOb9scZYGZ1ao0zlZP9Gt6BCm0JZias08+x46nREv/sXxlEbm5XYuE37CZzKl2Mywjwa5hxLJUL0xanoMlhcC57hf058WnUp1m+L9JbdEXJW1tDndHmWSbGDm/poBCcXfgvhKcHqMM1nzSs64LHk2cevhhoagIMu347+8+v6ON8m4URE9U4f2H/XsaXuNJzRHnLzFMsxzt3t/YfU8I0P5sJu/LZMJZEknFPsJjEX9x03J7Tp/GSQQn9k8XowHSEElkiFGT1OYvF9UA="
  },
  {
    "rawData": "The phenomenon of quantum entanglement has baffled scientists for decades, challenging our understanding of the very nature of reality itself.",
    "publicKey": "fX/N5MWNFjxG3wkWhguyb/iWIOED9oKC9VPYhbf6ICQ=",
    "privateKey": "EZ71Uw5nCfV5IwHYRDzFDN/ZFZMLfh8ImJA1ZUNeSlc=",
    "encryptedData": "g7kTRtcD4LxELZwfS6rUqLUN3SoCQVan5RVZhgURSbovdWVWBVtYZt+rgOnw9sL3JIBhWpV70MpAv1dM3g28hVD7BpCUNadLfiSG/ELASXWE1JWKJp6KaSFCqZmyqx6Qjhs3cowwl5s9r8+3eEwcptUeRX8BFNhm/Zp7CBy+lo1DZ2aRLUo2WhNiCn9hoFuZwvkXEYt3kNDYSBGjmZtdtNf4EhU5Zhb5rswuaFU2CcyE59MgFG0="
  },
  {
    "rawData": "Despite the seemingly insurmountable challenges that lay ahead, the team remained resolute in their determination to achieve their ambitious goals.",
    "publicKey": "fYWk+aU1YInCEOUMFcgGfvVByP1Pl1bqwQuvXN/UD3k=",
    "privateKey": "/xp3IZ+VQAtN4ZGbHQokB1YihYMHIrl9ac6BW8g/FXs=",
    "encryptedData": "yVCyOnCeHUtRy1MhWQQF1ez/HlzIdZWPr6bRHzF+43O93id0Lbfs9irukYyfT/Ttvn7V5wAqG8mLtnDcH4QMlBsI0lpU8fRXxKUvqI4RK+dmltJCW77gxUH1V8zyAy24sCRPcTRducbTwKum7wyHNs7HXOdZt0g4w57INO6salWH4yeJMkbxeJDh6HPbeW6eB4SAy9Vlq96AQFBlrf1rQn2fK2HEUAgFmmNIxp9JP8jFogAQRtEQD7ifvg=="
  },
  {
    "rawData": "The intricate web of relationships that define our social interactions is both fascinating and incredibly complex, revealing the depth of human connection.",
    "publicKey": "XpR3VWNInn6Ly8aeraDmqzAYpFi7G1G3dFCjM/q+fSM=",
    "privateKey": "gTxUedApV3L8NWesAZhV9amSXpOnFjSdUH1ukX47Ty4=",
    "encryptedData": "397suofCj12M4OKof66WWEN56q6AboCUbfqclikEH+W8NBuebD20tr411wfQokfUx7INb76mKBV1B/mHf7XsGfl3Rb+96+NQzbwbMOt5ucG2gm1zHoyNIjxCiAp1vhtYDXRxZwa+4WFU1B7IjMb+hVmTIeFJ46iG+ttCjjwvJQ+7ENbyrS1xRgya+GoJOGqIFGtYh5c7WfEJL8fHjqqPyRF22+kuBGO5b05J/rPkVkl4cph5Rx6mqx2Y0YPlv5/0ZXOH"
  },
  {
    "rawData": "Unraveling the mysteries of the human brain is one of the most formidable challenges in the field of neuroscience, requiring a multidisciplinary approach.",
    "publicKey": "EuVSGnnRsUMlstTszdbo5eVAY/EgZBBN1dTr7qqyZXU=",
    "privateKey": "w/1/tqANHlb3sLjocmHdrf8aThpEYTldq+C2LXaQxOs=",
    "encryptedData": "coqnPl/GXg2XbjICNuHMfkXS2PSvZYVmJfgbH3+oDCrwZeeKE5zbXnDcu8SJ/iiTDrcEibfjyjQVD3P++Weu4fhZkwZfmGVcIUzLiOwyBBk9fen6YryiQ8n7LCdr8IMWHxPnpfOrszUXvCO3Aa2kKE3XqhuEMev6jZ0EvwJkIrTG/RyU0KosODXGVflMPBl3iE1uqz5TkJrQduiDPxCwCz6CVDnkL9jsLF4ep59vSO1ceAtpPOLfzCSqTiPRb1GCW20="
  },
  {
    "rawData": "The concept of time travel has long captured the imagination of scientists and writers alike, though it remains firmly in the realm of theoretical speculation.",
    "publicKey": "HByJfUrHe0aWcKe4mv8a4VqzMR4Ie2/lmoNddLeuCCg=",
    "privateKey": "eZ/QoHgB3HI7OepHRQ82jetIW72mLJv37fQnWfA7iuU=",
    "encryptedData": "q51yTX0fy5ZuLGvTzx2Mwrio5DRs/Ig4EnMpKW3hrs9/3CvvtV6ZTLx4XecOLZsXrHTVls6oDnXgiqkbDXAcjwW7Mh8kr8CyO+JTqBSfaYrPb4IAiMjyuSTeRu70KFIUwOL7RjeiWPMWAaKw/5O+qAYCDHeun28Gu/Hw46oG/o8LNnUSCjR/NBdy9E4xDIyIBzMhbtJojWNBKE8EpaBUBbig1LjYwjbwLW96Y8VtVoLKla7tb2g9yEjj2qJGfHbje9w11zv4sQ=="
  },
  {
    "rawData": "As artificial intelligence continues to evolve, the debate over its potential benefits and risks grows increasingly urgent and contentious.",
    "publicKey": "3lcKkE+NR6PpwMMiz/2gF8NFLzpqAfhEgZJMmZbtrQw=",
    "privateKey": "KSozJ0Ronf/qiNlJ2KB6oJkL9xld5SpSIBKjnD4xVT0=",
    "encryptedData": "2hPf6OFabebG0ZZJ9c7Y8+5jUZtLSXY2MNTmKUzi2kjlqmObbQbWV8UyF0Gl3/22ueOxG7ie2+jikW/WAREELoQZ25+z/8JNXan8F9W47FO5Xy4ht2mxgeonndrux0Dt60AjPwxL1hARe5gV+DXG7SwEHdDp38V10KYUl8OWstJwkbob12jQDM2I/9Os285/PMW04o0AVal6Hr5peIDlscvTpApzg4lDeB4noaw/lZ76MYg="
  },
  {
    "rawData": "The uncharted depths of the ocean hold countless secrets, waiting to be discovered by those daring enough to explore its mysteries.",
    "publicKey": "He/TQKrkdPMijRK5IQnZ4aWWQhZoDZwGJMIoTZA/GVc=",
    "privateKey": "5ugVe82hW8OLi2eROXoMq/tjAaZD9Obg0sRer3bGAZg=",
    "encryptedData": "HhV+5Y+ice22xMDOF+sT+HkgWHSstfpDFYxJAyVNopEvwW9KWkN4PG3RZZvIp1M2GY5KOZMkMGJOYAiSc0FdEHS4M5RoW9Ky5v0z2qgY8Ln3KBh7ydPJn0/n4RQYCRqR9bTG7nH2eO4V+h2BmVD1VlHhWfI4xVsAcEFW5YZVQ775UW8dRBCPBsPnz5cdh4tanfvFkVua8M4dZUh/9bIug4k3Byh4yy54AWET"
  },
  {
    "rawData": "In the face of adversity, it is often the strength of the human spirit that shines through, illuminating the path forward with hope and resilience.",
    "publicKey": "PIjVcJoCIUfv3KvRqQnypJbsQzZulr3hbIYMy6LhXFk=",
    "privateKey": "4khL8rZDrIiX+sxGkJq7yX+pYHNqd8vMU/COmfvbr+c=",
    "encryptedData": "rQtFkLuxnFOUPauDpDgsycqOj5JKxzh6Ba965aqp7SpPZS5DtbfEt5/52gG7nB7g4NITiyftwrdLiyHhthKj6y7o2k4DCRCkJIp1kF4hUFvzoEYKNjtcMXeDOqHbmH5utjTQoZJVv+rUa+9BYP1jxP1V7gT2um/YPWyR02eNeeWEY8+w4taD8+wZraPcPWg3/ZJA0ryX2ZwZTT8X9Hx+/i5RC8EgjRqtCWHSpHqPkDlmBrF2mrFFQthiCA=="
  }
]

"""
  guard let jsonData = testData.data(using: .utf8) else {
    return []
  }
  return decodeJSONData([DataModel].self, from: jsonData) ?? []
}
