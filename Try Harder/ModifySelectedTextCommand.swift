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

	func redactTextInRange(_ range: XCSourceTextRange, inLines lines: NSMutableArray) -> String {
	
		let startLineIndex = range.start.line
		let endLineIndex = range.end.line

		for thisLineIndex in startLineIndex...endLineIndex {
			var thisLineString = lines[thisLineIndex] as! String
			var redactedRangeStart = 0
			var redactedRangeEnd = thisLineString.characters.count

			// If it's the first line, record the starting offset
			if (thisLineIndex == startLineIndex) {
				redactedRangeStart = range.start.column
			}

			// If this is the last line, then we're either selecting from the beginning (0)
			// or else we set the specific starting offset above
			if (thisLineIndex == endLineIndex) {
				redactedRangeEnd = range.end.column
			}

			let redactionStartIndex = thisLineString.index(thisLineString.startIndex, offsetBy:redactedRangeStart)
			let redactionEndIndex = thisLineString.index(thisLineString.startIndex, offsetBy:redactedRangeEnd)

			var redactionString = ""
			for _ in redactedRangeStart...redactedRangeEnd {
				redactionString = redactionString + "█"
			}

			thisLineString.replaceSubrange(redactionStartIndex...redactionEndIndex, with:redactionString)
			lines[thisLineIndex] = thisLineString
		}

		// There's something wrong with logic above - not working right for case where there is no selection
		return selectionString
	}

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {

		let textBuffer = invocation.buffer

		// Transform each selection by simply reversing the contents and replacing ...

		for selection in textBuffer.selections {

			if let selectionRange = selection as? XCSourceTextRange {

				redactTextInRange(selectionRange, inLines: textBuffer.lines)
			}
		}

        completionHandler(nil)
    }
}
