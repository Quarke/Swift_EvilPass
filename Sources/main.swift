//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(request: HTTPRequest, _ response: HTTPResponse) {

    let name = request.param(name: "name", defaultValue: "")
    let email = request.param(name: "email", defaultValue: "")
    let password = request.param(name: "password", defaultValue: "")

    guard !(name?.isEmpty)! else {
        response.appendBody(string: "Username is required!")
        response.completed()
        return
    }
    guard !(email?.isEmpty)! else {
        response.appendBody(string: "Email is required!")
        response.completed()
        return
    }
    guard !(password?.isEmpty)! else {
        response.appendBody(string: "Password is required!")
        response.completed()
        return
    }

    // Build the object that will be returned
    // Unwrap and add firstName to the returned object
    // Unwrap and add lastName to the returned object
    // Add emailAddress to the object if set
    // Set response content type as application/json
    // Set response status code as 200 OK
    // Set the response body with the above object
    // Complete the response
    response.completed()
}

func _check_twitter(username, email, password) {
	let request = NSURLRequest(URL: NSURL(string: "http://iswift.org")!)

	// Perform the request
	NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{
        (response: NSURLResponse?, data: NSData?, error: NSError?)-> Void in

            // Get data as string
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(str)
        }
    );
}

func _check_github(username, email, password) {

}

func _check_fb(username, email, password) {

}

func _check_google(username, email, password) {

}

func _check_hn(username, email, pw){

}

func _check_reddit(username, email, pw){

}

// Configuration data for two example servers.
// This example configuration shows how to launch one or more servers 
// using a configuration dictionary.

let port1 = 8080, port2 = 8181

let confData = [
	"servers": [
		// Configuration data for one server which:
		//	* Serves the hello world message at <host>:<port>/
		//	* Serves static files out of the "./webroot"
		//		directory (which must be located in the current working directory).
		//	* Performs content compression on outgoing data when appropriate.
		[
			"name":"localhost",
			"port":port1,
			"routes":[
				["method":"get", "uri":"/", "handler":handler],
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
				 "documentRoot":"./webroot",
				 "allowResponseFilters":true]
			],
			"filters":[
				[
				"type":"response",
				"priority":"high",
				"name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		],
		// Configuration data for another server which:
		//	* Redirects all traffic back to the first server.
		[
			"name":"localhost",
			"port":port2,
			"routes":[
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.redirect,
				 "base":"http://localhost:\(port1)"]
			]
		]
	]
]

do {
	// Launch the servers based on the configuration data.
	try HTTPServer.launch(configurationData: confData)
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

