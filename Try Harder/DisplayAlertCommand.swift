//
//  DisplayAlertCommand.swift
//  Try Harder
//
//  Created by Daniel Jalkut on 7/9/16.
//  Copyright © 2016 Daniel Jalkut. All rights reserved.
//

import Foundation
import AppKit
import XcodeKit

class DisplayAlertCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {

		// Extensions may be invoked on a thread, so you have to make sure the 
		// UI activity occurs on the extension process's own main thread.
		DispatchQueue.main.sync(execute: {

			let myAlert = NSAlert()
			myAlert.messageText = "Hello from a Source Editor extension!"

			// Make sure it floats above most UI
			myAlert.window.level = 999

			// I haven't figured out how to get it to appear as completely active
			NSApp.activate(ignoringOtherApps: true)
			myAlert.window.makeKeyAndOrderFront(nil)

			myAlert.runModal()
		})

        completionHandler(nil)
    }
}
