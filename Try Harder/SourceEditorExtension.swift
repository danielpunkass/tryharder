//
//  SourceEditorExtension.swift
//  Try Harder
//
//  Created by Daniel Jalkut on 7/9/16.
//  Copyright © 2016 Daniel Jalkut. All rights reserved.
//

import Foundation
import AppKit
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {

    func extensionDidFinishLaunching() {
		// Nothing yet
    }

	// You can advertise the list of supported Source Editor Extensions either 
	// by advertising them in Info.plist, or by implementing this method. I found it
	// easier during development of these demos to use the method approach, and
	// this approach, while simple, is not as well documented. So here is an example!
	//
	// NOTE: In order for this method to be reached, your extension must OMIT the
	// XCSourceEditorCommandDefinitions array under NSExtensionAttributes. The 
	// presence of that key, even if empty, seems to supercede the implementation
	// of this property being called.
	//
	// ALSO: If you have deleted app extension's plist-based command definitions,
	// you may need to build and run your host app manually to reset the registration
	// for your extension. Xcode seems to maintain a sort of cache and will continue 
	// using your app's Info.plist based list until it gets cleared.

	public var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {

		let productIdentifier = Bundle.main.infoDictionary![kCFBundleIdentifierKey as String] as! String

		func definitionForClassNamed(_ className: String, commandName: String) -> [XCSourceEditorCommandDefinitionKey: Any] {

			return [XCSourceEditorCommandDefinitionKey.identifierKey: productIdentifier + className,
					XCSourceEditorCommandDefinitionKey.classNameKey: className,
					XCSourceEditorCommandDefinitionKey.nameKey: commandName]
		}

		let myDefinitions : [[XCSourceEditorCommandDefinitionKey: Any]] = [
			definitionForClassNamed(OpenURLCommand.className(),
									commandName: NSLocalizedString("Try! Opening a Browser URL", comment:"")),
			definitionForClassNamed(DisplayAlertCommand.className(),
									commandName: NSLocalizedString("Try! Displaying an Alert", comment:"")),
			definitionForClassNamed(InsertPlaceholdersCommand.className(),
									commandName: NSLocalizedString("Try! Inserting Placeholders", comment:"")),
			definitionForClassNamed(ModifySelectedTextCommand.className(),
									commandName: NSLocalizedString("Try! Modifying Selected Text", comment:"")),
		]

        return myDefinitions
    }

}
