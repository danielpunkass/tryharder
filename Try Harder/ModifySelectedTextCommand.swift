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

	func stringForSelectedRange(_ range: XCSourceTextRange, fromLines lines: NSMutableArray) -> String {
		var selectionString = ""

		let startLineIndex = range.start.line
		let endLineIndex = range.end.line

		for thisLineIndex in startLineIndex...endLineIndex {
			let thisLineString = lines[thisLineIndex] as! NSString
			var capturedRange = NSMakeRange(0, thisLineString.length)

			// If it's the first line, record the starting offset
			if (thisLineIndex == startLineIndex) {
				capturedRange.location = range.start.column
				capturedRange.length = capturedRange.length - range.start.column
			}

			// If this is the last line, then we're either selecting from the beginning (0)
			// or else we set the specific starting offset above
			if (thisLineIndex == endLineIndex) {
				if (capturedRange.length != 0) {
					capturedRange.length = range.end.column - capturedRange.location + 1
				}
			}

			let addedString = thisLineString.substring(with: capturedRange)
			selectionString.append(addedString)
		}

		// There's something wrong with logic above - not working right for case where there is no selection
		return selectionString
	}

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {

		let textBuffer = invocation.buffer

		// Transform each selection by simply reversing the contents and replacing ...

		for selection in textBuffer.selections {

			if let selectionRange = selection as? XCSourceTextRange {

				let selectedString = stringForSelectedRange(selectionRange, fromLines: textBuffer.lines)

				if (false) { print("Warning: need to implement replacement - ideally by manipulating the lines buffer, but possibly by using the complete buffer") }
			}
		}

        completionHandler(nil)
    }
}
