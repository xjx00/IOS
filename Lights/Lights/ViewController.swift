//
//  ViewController.swift
//  Lights
//
//  Created by xjxpc on 16/8/24.
//  Copyright © 2016年 xjxpc. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var light: UISwitch!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var relogbtn: UIButton!
    
    @IBOutlet weak var lalert: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getstate()
        light.enabled = false
        loginWithTouchID()
        // Do any additional setup after loading the view, typically from a nib.
        light.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getstate(){
        let url = NSURL(string:"http://192.168.1.111/api=3")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        var response:NSURLResponse?
        
        do{
            do{
                //发出请求
                let received:NSData? = try NSURLConnection.sendSynchronousRequest(request,
                    returningResponse: &response)
//                let datastring = NSString(data:received!, encoding: NSUTF8StringEncoding)
//                print(datastring)
                let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions.AllowFragments)
                let state:AnyObject = json.objectForKey("state")!
                if(String(state) == "0"){
                    //print("lighton")
                    light.on = false
                    imgview.image = UIImage(named: "off.jpg")
                }else{
                    //print("lightoff")
                    light.on = true
                    imgview.image = UIImage(named: "on.jpg")
                }

                
            }catch let error as NSError{
                //打印错误消息
                //                print(error.code)
                //                print(error.description)
                UIAlertView(title:"错误",message:"error:\(error.description)",delegate:nil,cancelButtonTitle:"确定").show()
                
            }
        }
    }
    
    func lighton(){
        let url = NSURL(string:"http://192.168.1.111/api=1")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        var response:NSURLResponse?
        
        do{
            do{
                //发出请求
                let received:NSData? = try NSURLConnection.sendSynchronousRequest(request,
                    returningResponse: &response)
                //                let datastring = NSString(data:received!, encoding: NSUTF8StringEncoding)
                //                print(datastring)
                let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions.AllowFragments)
                let state:AnyObject = json.objectForKey("state")!
                if(String(state) == "on"){
                    //print("lighton")
                    imgview.image = UIImage(named: "on.jpg")
                }
                
            }catch let error as NSError{
                //打印错误消息
                //                print(error.code)
                //                print(error.description)
                UIAlertView(title:"错误",message:"error:\(error.description)",delegate:nil,cancelButtonTitle:"确定").show()
                light.on = false
                
            }
        }

    }
    
    func lightoff(){
        let url = NSURL(string:"http://192.168.1.111/api=0")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        var response:NSURLResponse?
        
        do{
            do{
                //发出请求
                let received:NSData? = try NSURLConnection.sendSynchronousRequest(request,
                    returningResponse: &response)
                //                let datastring = NSString(data:received!, encoding: NSUTF8StringEncoding)
                //                print(datastring)
                let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions.AllowFragments)
                let state:AnyObject = json.objectForKey("state")!
                if(String(state) == "off"){
                    //print("lighton")
                    imgview.image = UIImage(named: "off.jpg")
                }
                
            }catch let error as NSError{
                //打印错误消息
                //                print(error.code)
                //                print(error.description)
                UIAlertView(title:"错误",message:"error:\(error.description)",delegate:nil,cancelButtonTitle:"确定").show()
                light.on = true
                
            }
        }
        
    }
    
    func passwd(){
        let alertView = UIAlertView()
        alertView.title = "需要鉴定"
        alertView.message = "请输入密码"
        alertView.addButtonWithTitle("确定")
        alertView.addButtonWithTitle("取消")
        alertView.cancelButtonIndex = 1
        alertView.delegate = self
        alertView.alertViewStyle = UIAlertViewStyle.SecureTextInput
        alertView.show()
        }
    func alertView(alertView:UIAlertView,clickedButtonAtIndex buttonIndex:Int){
        if(buttonIndex == alertView.cancelButtonIndex){
            lalert.text = "鉴定失败"
            relogbtn.enabled = true
        }else{
            let pwd = alertView.textFieldAtIndex(0)
            //print("\(pwd!.text)")
            if(pwd!.text == "009009"){
                light.enabled = true
                lalert.text = ""
            }else{
                lalert.text = "鉴定失败"
                relogbtn.enabled = true
            }
        }
    }
    
    func loginWithTouchID()
    {
//            let context = LAContext()
//            var error: NSError?
//            let reasonString = "请输入指纹"
//            if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
//            {
//                context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,localizedReason: reasonString, reply: {(success,error) in
//                    if success
//                    {
//                    self.light.enabled = true
//                    self.lalert.text = ""
//                    }else{
//                        self.lalert.text = "鉴定失败"
//                        self.relogbtn.enabled = true
//                    }
//                    })
//                }else{
//                switch error!.code
//                {
//                    case LAError.TouchIDNotEnrolled.rawValue:
//                    //print("您还没有保存TouchID指纹")
//                    passwd()
//                    case LAError.PasscodeNotSet.rawValue:
//                    //print("您还没有设置密码")
//                    passwd()
//                default:
//                    //print("TouchID不可用")
                    passwd()
//                }
//            }
    }
    
    @IBAction func relogin(sender: AnyObject) {
        loginWithTouchID()
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            //print("The Switch1 is On\n")
            lighton()
        } else {
            //print("The Switch1 is Off\n")
            lightoff()
        }
    }

}

