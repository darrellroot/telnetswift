//
//  TelnetOptions.swift
//  telnetswift
//
//  Created by Darrell Root on 9/30/20.
//

import Foundation
import ArgumentParser

struct TelnetOptions: ParsableArguments {
    @Argument var host: String
    @Argument var port: Int = 23
}
