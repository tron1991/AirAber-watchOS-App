//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by Nick on 2016-02-25.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

    @IBOutlet var flightsTable: WKInterfaceTable!
    var selectedIndex = 0
    
    var flights = Flight.allFlights()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
        
        for index in 0..<flightsTable.numberOfRows {
            if let controller = flightsTable.rowControllerAtIndex(index) as? FlightRowController {
                controller.flight = flights[index]
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let flight = flights[rowIndex]
        let controllers = flight.checkedIn ? ["Flight", "BoardingPass"] : ["Flight", "CheckIn"]
        selectedIndex = rowIndex
        presentControllerWithNames(controllers, contexts: [flight, flight])
    }
    
    override func didAppear() {
        super.didAppear()
        // 1
        if flights[selectedIndex].checkedIn, let controller = flightsTable.rowControllerAtIndex(selectedIndex) as? FlightRowController {
            // 2
            animateWithDuration(0.35, animations: { () -> Void in
                // 3
                controller.updateForCheckIn()
            })
        }
    }

}
