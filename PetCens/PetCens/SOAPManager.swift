//
//  SOAPManager.swift
//  PetCens
//
//  Created by Infraestructura on 21/10/16.
//  Copyright © 2016 JanZelaznog. All rights reserved.
//

import Foundation

// segunda opcion: crear un protocolo
public protocol SOAPManagerDelegate:NSObjectProtocol {
    func WMRegresaMunicipiosResponse(responseArray:NSArray)
}

public class SOAPManager:NSObject, NSURLConnectionDelegate, NSXMLParserDelegate {
    var delegate:SOAPManagerDelegate?
    
    // Constantes
    private let NODO_RESULTADOS = "NewDataSet"
    private let NODO_MUNICIPIO = "ReturnDataSet"
    
    private var municipios:NSMutableArray?
    private var municipo:NSMutableDictionary?
    private var guardaResultados:Bool = false
    private var esMunicipio:Bool = false
    private var nombreCampo:String?
    
    static let instance:SOAPManager = SOAPManager()
    private let wsURL = "http://edg3.mx/webservicessepomex/sepomex.asmx"
    private var datosRecibidos:NSMutableData?
    private var conexion:NSURLConnection?
    
    public func consultaMunicipios (estado:String) {
        let soapMun1 = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><WMRegresaMunicipios xmlns=\"http://tempuri.org/\"><c_estado>"
        
        let soapMun2 = "</c_estado></WMRegresaMunicipios></soap:Body></soap:Envelope>"
        let soapMessage = soapMun1 + estado + soapMun2
        
        let laURL = NSURL(string: self.wsURL)!
        let elRequest = NSMutableURLRequest(URL: laURL)
        // Configurar el request
        elRequest.HTTPMethod = "POST"
        elRequest.setValue("text/xml", forHTTPHeaderField:"Content-Type")
        let longitudMensaje = "\(soapMessage.characters.count)"
        elRequest.setValue(longitudMensaje, forHTTPHeaderField:"Content-Length")
        elRequest.setValue("http://tempuri.org/WMRegresaMunicipios", forHTTPHeaderField:"SOAPAction")
        elRequest.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding)
        ////////////////////////////////////////////////
        self.datosRecibidos = NSMutableData(capacity: 0)
        self.conexion = NSURLConnection(request: elRequest, delegate: self)
        if self.conexion == nil {
            self.datosRecibidos = nil
            self.conexion = nil
            print ("No se puede acceder a WMRegresaMunicipios")
        }
    }
    public func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.datosRecibidos = nil
        self.conexion = nil
        print ("\t\t\t\t No se puede acceder a WMRegresaMunicipios: Error del server \t\t\t\t\t ")
        let ns = NSNotification(name: "WMRegresaMunicipiosError", object: nil, userInfo:nil)
        NSNotificationCenter.defaultCenter().postNotification(ns)
        
    }
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) { // Ya se logrò la conexion, preparando para recibir datos
        self.datosRecibidos?.length = 0
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) { // Se recibiò un paquete de datos. guardarlo con los demàs
    self.datosRecibidos?.appendData(data)
    }
    func connectionDidFinishLoading(connection: NSURLConnection){
        // SOAP response es un XML, implementar parseo
        let responseSTR = NSString(data: self.datosRecibidos!, encoding: NSUTF8StringEncoding)
        print (responseSTR)
        let xmlParser = NSXMLParser(data: self.datosRecibidos!)
        xmlParser.delegate = self
        xmlParser.shouldResolveExternalEntities = true
        xmlParser.parse()
    }
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == NODO_RESULTADOS {
            guardaResultados = true
        }
        if guardaResultados && elementName == NODO_MUNICIPIO {
            self.municipo = NSMutableDictionary()
            esMunicipio = true
        }
        nombreCampo = elementName
    }
    public func parser(parser: NSXMLParser, foundCharacters string: String) {
        if esMunicipio {
            municipo!.setObject(string, forKey:nombreCampo!)
        }
    }
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == NODO_MUNICIPIO {
            if municipios == nil {
                municipios = NSMutableArray()
            }
            municipios!.addObject(municipo!)
            esMunicipio = false
        }
    }
    public func parserDidEndDocument(parser: NSXMLParser) {
        if municipios != nil {
            print ("\t\n resultado, parseado: \(municipios!.description) \t\n")
            // primera opcion: usar una notificacion:
            let ns = NSNotification(name: "WMRegresaMunicipios", object: nil, userInfo:["WMRegresaMunicipiosResponse":self.municipios!])
            NSNotificationCenter.defaultCenter().postNotification(ns)
            // segunda opcion: usar el protocolo
            if delegate != nil {
                if delegate!.respondsToSelector(Selector("WMRegresaMunicipiosResponse")) {
                    delegate!.WMRegresaMunicipiosResponse(self.municipios!)
                }
            }
        }
        else{
            let ns = NSNotification(name: "WMRegresaMunicipiosError", object: nil, userInfo:nil)
            NSNotificationCenter.defaultCenter().postNotification(ns)
        }
    }
}


/*
 Notificaciones son manejadas por el NotificationCenter
 post notificaion es enviar una notificacion al NotificationCenter
 
 
 */


