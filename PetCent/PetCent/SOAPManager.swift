//
//  SOAPManager.swift
//  PetCent
//
//  Created by Infraestructura on 21/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import Foundation

public class SOAPManager:NSObject, NSURLConnectionDelegate, NSXMLParserDelegate {

    private let NODO_RESULTADOS: String = "NewDataSet"
    private let NODO_MUNICIPIO: String = "ReturnDataSet"
    private var municipios : NSMutableArray?
    private var municipio : NSMutableDictionary? //c_mnpio
    private var guardaResultados:Bool = false
    private var esMunicipio:Bool = false
    private var nombreCampo: String?
    
    static let instance: SOAPManager = SOAPManager()
    //Se inicializa ahi mismo
    
    
    private let urlSepomex = "http://edg3.mx/webservicessepomex/sepomex.asmx"
    //Se inicialzia con vare por que cambiara su contewnido a cada peticion
    private var conexion: NSURLConnection?
    private var datosRecibidos: NSMutableData?

    
    public func consultaMunicipio (estado: String){
        
        
        let soapMun1 = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><WMRegresaMunicipios xmlns=\"http://tempuri.org/\"><c_estado>"
        
        let soapMun2 = "</c_estado></WMRegresaMunicipios></soap:Body></soap:Envelope>"
        
        
        
        let soapCol1 = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><WMRegresaColonias xmlns=\"http://tempuri.org/\"><c_estado>"
        
        let soapCol2 = "</c_estado><c_mnpio>"
        
        let soapCol3 = "</c_mnpio></WMRegresaColonias></soap:Body></soap:Envelope>"

        let soapMessage = soapMun1 + estado + soapMun2
           if (ConnectionManager.hayConexion()){
            if !ConnectionManager.esConexionWifi() {
                print("Si hay conexion if ask download long data")
            }
            
            
            let laUrl = NSURL(string:urlSepomex)!
            let elRequest = NSMutableURLRequest (URL: laUrl)
            
            //configurar el request
            elRequest.HTTPMethod = "POST"
            elRequest.setValue("text/xml", forHTTPHeaderField: "Content-Type")
            let longitudMessage = "\(soapMessage.characters.count)"
            elRequest.setValue(longitudMessage , forHTTPHeaderField: "Content-Length")
            elRequest.setValue("http://tempuri.org/WMRegresaMunicipios", forHTTPHeaderField: "SOAPAction")
            elRequest.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding)
            //termina configuracion
            
            self.datosRecibidos = NSMutableData(capacity:0)
            self.conexion = NSURLConnection(request: elRequest, delegate: self)
            if self.conexion == nil{
                self.datosRecibidos = nil
                self.conexion = nil
                print("No se puede acceder al SOAP ")
                
            }
            else{
                print("carga datos de peticion SOAP ")
            }
        }
        else{
            print("No hay conexion wi-fi or data")
        }
    }
    
    
    // en automatico ejeecuta este cuando se ejecuta  self.conexion = NSURLConnection(request: elRequest, delegate: self)
    public func connection(connection: NSURLConnection, didFailWithError error: NSError){
        self.datosRecibidos = nil
        self.conexion = nil
        print("Sin conexion")
    }
    // en automatico ejecuta este cuando responde la  self.conexion
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        self.datosRecibidos?.length = 0
    }
    
    // en automatico ejecuta este cuando se esta recibiendo datos
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        //la operación de datos se debe agregar en paquetes para toda la transmisión
        self.datosRecibidos?.appendData(data)
        
    }
    
    // cuando termina la peticion
    func connectionDidFinishLoading(connection: NSURLConnection){
        // Ahora se utiliza el responsae para convertir el xml e implementat el parseo
        do{
            let responseSTR = NSString(data: self.datosRecibidos!, encoding: NSUTF8StringEncoding)
            print(responseSTR)
            let xmlParser = NSXMLParser(data: self.datosRecibidos! as Data)
            xmlParser.delegate = self
            xmlParser.shouldResolveExternalEntities = true
            xmlParser.parse()
        }catch{
            print("Conection to traslate data to xml")
        }
    }
    
    //   / Como la peticion viene en xml hay que parsearlo para tener todos los objetos de la clase nsl parser esto lo hace todas las veces
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?, attributes attributeDict: [String : String]){
        if elementName == NODO_RESULTADOS {
            guardaResultados = true
            
        }
        if guardaResultados && elementName == NODO_MUNICIPIO {
            self.municipio = NSMutableDictionary()
            esMunicipio = true
        }
        nombreCampo = elementName
        
    }
    //Esta peticion la hace a cada vez que lee y cierra
    
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?){
        if elementName == NODO_MUNICIPIO {
            if municipios == nil {
                municipios = NSMutableArray()
            }
            municipios!.addObject(municipio!)
            esMunicipio = false
        }
    }
    
    //Sirve para leer el valor de cada nodo leido
    public func parser(parser: NSXMLParser, foundCharacters string: String){
        if esMunicipio {
            municipio!.setObject(string, forKey: nombreCampo!)
        }
    }
    
    public func parserDidEndDocument(parser: NSXMLParser){
        print("Resultado parseado: \t \(municipios!.description)")
    }
    
    
}





