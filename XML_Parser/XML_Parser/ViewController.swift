//
//  ViewController.swift
//  XML_Parser
//
//  Created by Abe Rodriguez on 1/26/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {

    @IBOutlet weak var MyTableView: UITableView!

    var eName: String = String()
    var TVTitle: [String] = []
    var TVSummary:[String] = []
    var episode:[String] = []
    var TVImage:[String] = []
    var name = 1
    var xmldata:NSString = ""
    var xmlParser = XMLParser()
    var XMLString = XMLData()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DisplayURL()

    } // End of viewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } // End of didReceiveMemoryWarning
    
/********************************************************
     Runs through each element.
*********************************************************/
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        eName = elementName
        
        if elementName == "im:artist" || elementName == "summary" || elementName == "im:name"
        {
            if elementName == "im:artist"
            {
                XMLString.ShowTitle = ""
            }
            if elementName == "summary"
            {
                XMLString.EpiSummary = ""
            }
            if elementName == "im:name"
            {
                XMLString.EpiName = ""
            }
            if elementName == "im:image"
            {
                XMLString.EpiImage = ""
            }
        }
    } // End of didStartElement
    
/********************************************************
     Stores the data in current variables.
*********************************************************/
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty)
        {
            if eName == "im:artist"
            {
                XMLString.ShowTitle.append(data)
            }
            else if eName == "summary"
            {
                XMLString.EpiSummary.append(data)
            }
            else if eName == "im:name"
            {
                XMLString.EpiName.append(data)
            }
            else if eName == "im:image"
            {
                XMLString.EpiImage.append(data)
                print(XMLString.EpiImage)
            }
        }
    }  // End of foundCharacter
    
/********************************************************
     Stores the data once the parser reaches the end of an
     element and then deletes current variables.
*********************************************************/
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "im:artist" || elementName == "summary" || elementName == "im:name"
        {
            // the name of the episode
            if elementName == "im:artist"
            {
                TVTitle.append(XMLString.ShowTitle)
                XMLString.ShowTitle = ""
            }
            else if elementName == "summary"
            {
                TVSummary.append(XMLString.EpiSummary)
                XMLString.EpiSummary = ""
            }
            else if elementName == "im:image"
            {
                TVImage.append(XMLString.EpiImage)
            }
            //  Check and capture name of episode because there are 2 intanses of "im:name" within an entry
            else if elementName == "im:name"
            {
                if name % 2 == 1
                {
                    // captures the TV show name
                    episode.append(XMLString.EpiName)
                    XMLString.EpiName = ""
                    name += 1
                }
                else
                {
                    name += 1
                }
            }
            else
            {
                // Clears any string currently loaded in variables
                XMLString.ShowTitle = ""
                XMLString.EpiSummary = ""
            }
        }
    }  // End of didEndlement
    
/********************************************************
    Checking to see if document has reached the end.
     If so it will reload tableView with the parsed data.
*********************************************************/
    public func parserDidEndDocument(_ parser: XMLParser)
    {
        // Reload the tableView with the data.
        self.MyTableView.reloadData()
    }  // End of parserDidEndDocument
    
/*********************************************************
     Checking for parser arrors
**********************************************************/
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print("failure error: ", parseError)
    }  // End of parseErrorOccurred
    
/*********************************************************
     Functon DisplayURL ()
        Starts a URLSession (runs in the backgroumd). Once the
        session has resumed in the back ground it then, starts 
        parsing the data.
**********************************************************/
    func DisplayURL () {
        let url = URL(string: "https://itunes.apple.com/us/rss/toptvepisodes/limit=25/genre=4008/xml")!
        
        let session = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            guard let data = data else {
                print("data is nil")
                return
            }
            // store the XML data from the URL Session
            self.xmldata = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
            self.xmlParser = XMLParser(data: data)
            // Check if the xmlParser has been created.
            if self.xmlParser != nil {
                print("xmlParser created")
                self.xmlParser.delegate = self
                self.xmlParser.parse()
            }
        }
        session.resume()
    }
    
/****************************************************************************
     Populates table view from data stored from in arrays after being parsed
*****************************************************************************/
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (TVTitle.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.season.text = episode[indexPath.row]
        cell.titles.text = TVTitle[indexPath.row]
        cell.summary.text = TVSummary[indexPath.row]
        
        
        
//        URL *imageURL = [URL URLWithString:[[self.listOfPlaceDetails objectAtIndex: TVImage[indexPath.row]]objectForKey:@"im:img"]];
//        NSData.self *imageData = [NSData dataWithContentsOfURL:imageURL];
//        UIImage.self *image = [UIImage imageWithData:imageData];
        //cell.MyImage.image = [UIImage .animatedImage(with: [NSData dataWithContentsOfURL:TVImage[indexPath.row]], duration: 250)];
        

        return (cell)
    }
}// ViewController Class
