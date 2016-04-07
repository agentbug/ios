//
//  FirstViewController.swift
//  testAppartoo
//
//  Created by zh ch on 07/04/16.
//  Copyright (c) 2016 Chong. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    //table
    @IBOutlet weak var tblBars: UITableView!
    
    var barsArray: [Bar] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        iniTable()
        jsonParsingFromFile()
        
        
        let loadVC = self.storyboard?.instantiateViewControllerWithIdentifier("map") as! SecondViewController
        
        loadVC.barsArray = barsArray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //initialization
    func iniTable(){
        
        self.tblBars.registerClass(UITableViewCell.self, forCellReuseIdentifier: "bar")
        self.tblBars.rowHeight = 120
        
        tblBars.dataSource = self
        tblBars.delegate = self
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barsArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return "Bars"
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "bar")
        
        
        
        cell.textLabel?.font = UIFont(name:"Avenir", size:15)
        
        cell.textLabel?.text = barsArray[indexPath.row].name
        var strTag = " \nTag: "
        
        var strAddress = barsArray[indexPath.row].address! + strTag
        
        var strFinal = strAddress + barsArray[indexPath.row].tags
        
        
        
        cell.detailTextLabel?.text = strFinal
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        
        
        let url = NSURL(string: barsArray[indexPath.row].image_url!)
        let data = NSData(contentsOfURL: url!)
        cell.imageView?.image = UIImage(data: data!)
        
        return cell
    }
    
    
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        var indexBar = indexPath.item
        
        //print(indexPath.item)
        
        let loadVC = self.storyboard?.instantiateViewControllerWithIdentifier("singleMap") as! BarMap
        
        loadVC.bar = barsArray[indexPath.item]
        
        
        
         self.presentViewController(loadVC, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    
    
    

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //read json to objects
    func jsonParsingFromFile(){
        if let path = NSBundle.mainBundle().pathForResource("Pensebete", ofType: "json"){
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil){
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary{
                    if let bars : NSArray = jsonResult["bars"] as? NSArray{
                        //print(bars)
                        for bar in bars{
                            
                            if let dict = bar as? NSDictionary{
                                
                                var b = Bar(json: dict)
                                
                                barsArray.append(b)
                            }
                        }
                        
                    }
                }
            }
        }
    }

    

}

