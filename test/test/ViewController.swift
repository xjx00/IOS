//
//  ViewController.swift
//  test
//
//  Created by xjxpc on 16/8/19.
//  Copyright © 2016年 xjxpc. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var server: UILabel!
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var ipaddr: UILabel!
    
//    @IBOutlet weak var led1: UISwitch!
//    
//    @IBOutlet weak var led2: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTemp()
        // Do any additional setup after loading the view, typically from a nib.
//        let background = UIImage(named:"background.jpg")
//        self.view.backgroundColor = UIColor(patternImage: background!)
//        led1.addTarget(self, action: Selector("led1stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
//        led2.addTarget(self, action: Selector("led2stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func gettemp(sender: AnyObject) {
        temp.text="world"
        getTemp()
    }
    
    func getTemp(){
    
        let url = NSURL(string:"http://xjx00.ittun.com/api/public/demo/?service=sys.info")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        var response:NSURLResponse?
        do{
            do{
                //发出请求
                let received:NSData? = try NSURLConnection.sendSynchronousRequest(request,
                    returningResponse: &response)
                //let datastring = NSString(data:received!, encoding: NSUTF8StringEncoding)
                //print(datastring)
                let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions.AllowFragments)
                let data:AnyObject = json.objectForKey("data")!
                let kernel_info:AnyObject = data.objectForKey("kernel_info")!
                let Temp:AnyObject = data.objectForKey("temp")!
                let ip:AnyObject = data.objectForKey("ip")!
                server.text = "\(kernel_info)"
                temp.text = "\(Temp)"
                ipaddr.text = "\(ip)"
                
                
                
            }catch let error as NSError{
                //打印错误消息
//                print(error.code)
//                print(error.description)
                UIAlertView(title:"错误",message:"error:\(error.description)",delegate:nil,cancelButtonTitle:"确定").show()
            
        }
    }
}
//    func led1stateChanged(switchState: UISwitch) {
//        if switchState.on {
//            print("The Switch1 is On\n")
//        } else {
//            print("The Switch1 is Off\n")
//        }
//    }
//    
//    func led2stateChanged(switchState: UISwitch) {
//        if switchState.on {
//            print("The Switch2 is On\n")
//        } else {
//            print("The Switch2 is Off\n")
//        }
//        
//    }
}