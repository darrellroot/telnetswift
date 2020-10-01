//
//  main.swift
//  telnetswift
//
//  Created by Darrell Root on 9/30/20.
//

import Foundation

let options = TelnetOptions.parseOrExit()

debugPrint("destination \(options.host) port \(options.port)")

let reader: TcpReader
do {
    reader = try TcpReader(hostname: options.host, port: options.port)
} catch {
    print("\(#file) \(#function) error \(error.localizedDescription)")
    exit(EXIT_FAILURE)
}
/*DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    debugPrint("trying to send GET")
    reader.send("GET /\n")
}*/

while let input = readLine(strippingNewline: false) {
    reader.send(input)
}
RunLoop.main.run()
