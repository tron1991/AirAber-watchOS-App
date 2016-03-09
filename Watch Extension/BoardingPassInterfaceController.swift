//
//  BoardingPassInterfaceController.swift
//  AirAber
//
//  Created by Nick on 2016-02-25.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class BoardingPassInterfaceController: WKInterfaceController {
    
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var boardingPassImage: WKInterfaceImage!
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    

    var flight: Flight? {
        didSet {
            if let flight = flight {
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
            }
            
            if let _ = flight!.boardingPass {
                showBoardingPass()
            }
        }

    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let flight = context as? Flight {
            self.flight = flight
        }
    }
    
    override func didAppear() {
        super.didAppear()
        // 1
        if let flight = flight where flight.boardingPass == nil && WCSession.isSupported() {
            // 2
            session = WCSession.defaultSession()
            // 3
            session!.sendMessage(["reference": flight.reference], replyHandler: { (response) -> Void in
                // 4
                if let boardingPassData = response["boardingPassData"] as? NSData, boardingPass = UIImage(data: boardingPassData) {
                    // 5
                    flight.boardingPass = boardingPass
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showBoardingPass()
                    })
                }
                }, errorHandler: { (error) -> Void in
                    // 6
                    print(error)
            })
        }
    }

    private func showBoardingPass() {
        boardingPassImage.stopAnimating()
        boardingPassImage.setWidth(120)
        boardingPassImage.setHeight(120)
        boardingPassImage.setImage(flight?.boardingPass)
    }
}

extension BoardingPassInterfaceController: WCSessionDelegate {
    
}
