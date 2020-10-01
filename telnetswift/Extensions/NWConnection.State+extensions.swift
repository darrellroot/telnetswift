//
//  NWConnection.State+extensions.swift
//  telnetswift
//
//  Created by Darrell Root on 9/30/20.
//

import Foundation
import Network

extension NWConnection.State: CustomStringConvertible {
    public var description: String {
        switch self {
        
        case .setup:
            return "setup"
        case .waiting(_):
            return "waiting"
        case .preparing:
            return "preparing"
        case .ready:
            return "ready"
        case .failed(_):
            return "failed"
        case .cancelled:
            return "cancelled"
        }
    }
}
