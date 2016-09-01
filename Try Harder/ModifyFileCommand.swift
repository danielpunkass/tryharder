//
//  ModifySelectedTextCommand.swift
//  Try Harder
//
//  Created by Daniel Jalkut on 7/9/16.
//  Copyright © 2016 Daniel Jalkut. All rights reserved.
//

import Foundation
import AppKit
import XcodeKit

class ModifySelectedTextCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {

		// When making changes that may affect text anywhere within a file, Apple recommends
		// taking advantage of the "lines" array  only the selected text, we don't need to concern ourselves
		// with efficiencies in the same way we do with changes that may affect
		// the whole file. Just grab the selection and update it:
if (false) { print("Warning: do this" ) }
        completionHandler(nil)
    }
}
