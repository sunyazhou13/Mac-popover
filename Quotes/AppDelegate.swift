//
//  AppDelegate.swift
//  Quotes
//
//  Created by sunyazhou on 16/3/1.
//  Copyright © 2016年 Baidu, Inc. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = Selector("togglePopover:")  //Selector("printQuote:")
        }
        popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
        
        
        eventMonitor = EventMonitor(mask: [.LeftMouseUpMask, .RightMouseUpMask]) { event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
        
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


    func showpPopover(sender: NSStatusBarButton?)
    {
        if let button  = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    
    func closePopover(sender: AnyObject?)
    {
        popover.performClose(sender)
    }
    
    func togglePopover(sender: NSStatusBarButton?)
    {
        if popover.shown {
            closePopover(sender)
            eventMonitor?.stop()
        }
        else {
            showpPopover(sender)
            eventMonitor?.start()
        }
    }
}

