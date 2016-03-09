//
//  FlightInterfaceController.swift
//  AirAber
//
//  Created by Nick on 2016-02-24.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class FlightInterfaceController: WKInterfaceController {

    @IBOutlet var flightLabel: WKInterfaceLabel!
    @IBOutlet var routeLabel: WKInterfaceLabel!
    @IBOutlet var boardingLabel: WKInterfaceLabel!
    @IBOutlet var boardTimeLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var gateLabel: WKInterfaceLabel!
    @IBOutlet var seatLabel: WKInterfaceLabel!
    
    var flight : Flight? {
        //2
        didSet {
            if let flight = flight {
                //4 
                flightLabel.setText("Flight \(flight.shortNumber)")
                routeLabel.setText(flight.route)
                boardingLabel.setText("\(flight.number) Boards")
                boardTimeLabel.setText(flight.boardsAt)
                
                //5
                if flight.onSchedule {
                    statusLabel.setText("On Time")
                } else {
                    statusLabel.setText("Delayed")
                    statusLabel.setTextColor(UIColor.redColor())
                  }
                gateLabel.setText("Gate \(flight.gate)")
                gateLabel.setText("Seat \(flight.seat)")
                }
            }
        }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let flight = context as? Flight {
            self.flight = flight
        }
    }
    
    
}


