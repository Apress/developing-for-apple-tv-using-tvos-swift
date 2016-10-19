//
//  FirstViewController.swift
//  WeatherStation
//
//  Created by Gary Bennett on 11/16/15.
//  Copyright © 2015 xcelMe. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityNameOutlet: UILabel!
    @IBOutlet weak var tempOutlet: UILabel!
    @IBOutlet weak var weatherOutlet: UILabel!
    
    var cities = ["Austin","Dallas","Phoenix", "Portand", "San Diego", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = (self.cities[indexPath.row])
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        self.getWeatherData(cities[row])
    }
    
    func getWeatherData(city:String){
        let  urlString :String = city.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
        //PLEASE VISIT http://home.openweathermap.org/users/sign_up to get your API Key. Insert your API key below
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(urlString),us&APPID=391cb2c14e489e43e09acd866e647d4f")
        let getData = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data,response,error ) in
            dispatch_async(dispatch_get_main_queue(), {
                self.setLables(data!)
            })
        }
        getData.resume()
    }
    
    func tableView(tableView: UITableView, canFocusRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 1 {
            return false
        }
        return true
    }
    
    func setLables(weatherData:NSData) {

        do {
            let jsonData = try NSJSONSerialization.JSONObjectWithData(weatherData, options: [])
            let dataOut = jsonData as! Dictionary<String,AnyObject>
            if let city = dataOut["name"] as? String {
                cityNameOutlet.text = city
            }
            if let mainDictionary:Dictionary = dataOut["main"] as? Dictionary<String,AnyObject>{
                let kelvin = mainDictionary["temp"] as! Double
                let celsius = kelvin - 273.15
                let fahrenheit = 9/5 * celsius + 32
                tempOutlet.text = String(format: "%.f", fahrenheit)
            }
            
            if let weatherDict = dataOut["weather"]![0]{
                weatherOutlet.text = weatherDict["description"] as? String
                
            }
        }
        catch {
            print("Fetch failed:")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

