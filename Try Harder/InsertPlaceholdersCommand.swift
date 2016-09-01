//
//  InsertPlaceholdersCommand.swift
//  Try Harder
//
//  Created by Daniel Jalkut on 7/9/16.
//  Copyright © 2016 Daniel Jalkut. All rights reserved.
//

import Foundation
import AppKit
import XcodeKit

class InsertPlaceholdersCommand: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {

		let textBuffer = invocation.buffer

		// For this example we'll assume non-destructive insertion before the user's
		// first selection (or the insertion point if no selection)
		if let selectedRange = textBuffer.selections[0] as? XCSourceTextRange {

			// Collapse selection to start
			selectedRange.end = selectedRange.start

			// Target the beginning of the selection
			let lineIndex = selectedRange.start.line
			let columnIndex = selectedRange.start.column

			// To take advantage of Xcode's standard "placeholder" functionality,
			// just wrap your placeholders in the required magic delimiters...
			func placeholder(_ name:String) -> String {
				let openTag = "<#"
				let closeTag = "#>"
				return openTag + name + closeTag
			}

			let insertedText = "The quick \(placeholder("color")) fox jumped over the \(placeholder("adjective")) dog"

			var insertionLine = textBuffer.lines[lineIndex] as! String
			let insertionIndex = insertionLine.index(insertionLine.startIndex, offsetBy:columnIndex)
			insertionLine.insert(contentsOf: insertedText.characters, at:insertionIndex)
			textBuffer.lines[lineIndex] = insertionLine
		}

        completionHandler(nil)
    }
}
