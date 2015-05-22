//
//  Document.swift
//  LiterateSwift2
//
//  Created by Chris Eidhof on 22/05/15.
//  Copyright (c) 2015 Unsigned Integer. All rights reserved.
//

import Cocoa
import CommonMark

class MarkdownDocument: NSDocument {
    
    var node: Node? {
        didSet {
            dispatch_async(dispatch_get_main_queue()) {
                callback?(node)
            }
        }
    }
    
    var callback: (Node? -> ())?

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)!
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
    }
    
    func reload() {
        node = fileURL?.path.flatMap(parseFile)
    }
   
    override func readFromURL(url: NSURL, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        reload()
 
        return true
    }
    
    override func presentedItemDidChange() {
        reload()
    }

}

