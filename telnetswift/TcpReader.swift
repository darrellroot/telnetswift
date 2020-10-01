//
//  TcpReader.swift
//  telnetswift
//
//  Created by Darrell Root on 9/30/20.
//

import Foundation
import Network

class TcpReader {
    let connection: NWConnection
    
    init(hostname: String, port: Int) throws {
        guard port > 0 && port < 65536 else {
            throw TelnetError.invalidPort
        }
        guard let portEndpoint = NWEndpoint.Port(port.description) else {
            throw TelnetError.invalidPort
        }
        let endpoint = NWEndpoint.hostPort(host: NWEndpoint.Host(hostname), port: portEndpoint)
        
        let nwParameters = NWParameters()
        self.connection = NWConnection(to: endpoint, using: .tcp) //TODO set NWParameters
        
        connection.stateUpdateHandler = { [weak self] (newState) in
            debugPrint("\(#file) \(#function) \(newState.description)")
            switch newState {
            
            case .setup:
                break
            case .waiting(_):
                break
            case .preparing:
                break
            case .ready:
                self?.receive()
                break
            case .failed(_):
                break
            case .cancelled:
                break
            }
        }
        connection.start(queue: DispatchQueue.global())
    }
    func receive() {
        //debugPrint("setting up receive")
        connection.receive(minimumIncompleteLength: 1, maximumLength: 16384) { (content, context, isComplete, error) in
            if let content = content, content.count > 0, let string = String(data: content, encoding: .utf8) {
                print(string, terminator: "")
            }
            if let error = error {
                print("\(#file) \(#function): \(error.localizedDescription)",STDERR_FILENO)
            }
            if !isComplete {
                self.receive()
            } else {
                exit(EXIT_SUCCESS)
            }
        }
    }
    func send(_ string: String) {
        guard let content = string.data(using: .utf8) else {
            return
        }
        self.send(content)
    }
    func send(_ content: Data) {
        connection.send(content: content, completion: .contentProcessed({ (error) in
            if let error = error {
                print("\(#file) \(#function): \(error.localizedDescription)",STDERR_FILENO)
            }
        }))
    }
}
