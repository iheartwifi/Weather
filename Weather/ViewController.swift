//
//  ViewController.swift
//  Weather
//
//  Created by Wifi on 2017-03-13.
//  Copyright © 2017 iheartwifi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var cityField: UITextField!
    
    @IBOutlet var resultLabl: UILabel!

    
    @IBAction func submitPressed(_ sender: Any) {
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                var message = ""
                
                if error != nil {
                    
                    print(error)
                    
                } else {
                    
                    if let unwrappedData = data {
                        
                        
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            
                            if contentArray.count > 1 {
                                
                                stringSeparator = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                
                                if newContentArray.count > 1 {
                                    
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    
                                    print(message)
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
                
                if message == "" {
                    
                    message = "It there couldn't be found. Please try again."
                    
                }
                
                DispatchQueue.main.sync(execute: {
                    
                    self.resultLabl.text = message
                    
                })
                
            }
            
            task.resume()
            
        } else {
            resultLabl.text = "It there couldn't be found. Please try again."
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

