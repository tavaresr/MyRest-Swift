//
//  NSURLConnection.swift
//  MyRest
//
//  Created by Ricardo Tavares (Miguel Duarte).
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

public enum JSONResult
{
    case Array(NSArray)
    case Dictionary(NSDictionary)
    case Error(NSError)
}

public extension NSURLConnection {
    public class func jsonFromRequest(request:NSURLRequest, result:(value:JSONResult)->())
    {
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            urlResponse, data, error in
            
            if let erro = error {
                print(erro)
                result(value: .Error(erro))
            } else {
                
                var erros :NSError? = nil
                var json : AnyObject!
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments )
                } catch var error as NSError {
                    erros = error
                    json = nil
                } catch {
                    fatalError()
                }
                if let erro = erros {
                    result(value: .Error(erro))
                }
                if (json is NSArray)
                {
                    result(value: .Array(json as! NSArray))
                }
                else if (json is NSDictionary)
                {
                    result(value: .Dictionary(json as! NSDictionary))
                }
            }
        }
    }
    
    public class func jsonFromUrl(url:NSURL, result:(value:JSONResult)->())
    {
        let request = NSURLRequest(URL: url)
        jsonFromRequest(request) { value in
            result(value: value)
        }
    }
}

