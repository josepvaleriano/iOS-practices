//
//  NuevoRViewController.swift
//  PetCens
//
//  Created by Jan Zelaznog on 15/10/16.
//  Copyright © 2016 JanZelaznog. All rights reserved.
//

import UIKit

class NuevoRViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var estados:NSArray?
    var municipios:NSArray?
    var colonias:NSArray?
    var conexion:NSURLConnection?
    var datosRecibidos:NSMutableData?
    var solcecito:LoadingView?
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApels: UITextField!
    @IBOutlet weak var txtFechaNac: UITextField!
    @IBOutlet weak var txtCalleNo: UITextField!
    @IBOutlet weak var txtColonia: UITextField!
    @IBOutlet weak var txtMunicipio: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    @IBOutlet weak var pickerFN: UIDatePicker!
    @IBOutlet weak var pickerEstados: UIPickerView!
    @IBOutlet weak var pickerMuns: UIPickerView!
    @IBOutlet weak var pickerCols: UIPickerView!
    
    @IBAction func pickerDateChanged(sender: AnyObject) {
        let formato = NSDateFormatter()
        formato.dateFormat = "dd-MM-yyyy"
        let fechaString = formato.stringFromDate(self.pickerFN.date)
        self.txtFechaNac.text = fechaString
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerEstados.isEqual(pickerView) {
            return estados!.count
        }
        else if pickerMuns.isEqual(pickerView) {
            return municipios!.count
        }
        else {
            return colonias!.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerEstados.isEqual(pickerView) {
            return (estados![row].valueForKey("nombreEstado") as! String)
        }
        else if pickerMuns.isEqual(pickerView) {
            return (municipios![row] as! String)
        }
        else {
            return (colonias![row] as! String)
        }    }

    func subeBajaPicker(elPicker:UIView, subeObaja:Bool) {
        var elFrame:CGRect = elPicker.frame
        UIView.animateWithDuration(0.5) {
            if subeObaja {
                elFrame.origin.y = CGRectGetMaxY(self.txtFechaNac.frame)
                elPicker.hidden = false
            }
            else {
                elFrame.origin.y = CGRectGetMaxY(self.view.frame)
            }
            elPicker.frame = elFrame
        }
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.isEqual(self.txtNombre) ||
            textField.isEqual(self.txtApels) ||
            textField.isEqual(self.txtCalleNo) {
            self.ocultaPickers()
            return true
        }
        else {
            self.txtNombre.resignFirstResponder()
            self.txtApels.resignFirstResponder()
            self.txtCalleNo.resignFirstResponder()
            if textField.isEqual(self.txtFechaNac) {
                self.subeBajaPicker(self.pickerFN, subeObaja: true)
            }
            // TODO: otros pickers
            
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtNombre.delegate = self
        self.txtApels.delegate = self
        self.txtFechaNac.delegate = self
        self.txtCalleNo.delegate = self
        self.txtColonia.delegate = self
        self.txtMunicipio.delegate = self
        self.txtEstado.delegate = self
        self.pickerFN.hidden = true
        self.pickerEstados.delegate = self
        self.pickerEstados.dataSource = self
        self.estados = NSArray()
        // Inicializar con datos temporales
        self.municipios = ["no", "si", "talvez"]//NSArray()
        self.colonias = NSArray()
        /// toDO: revisar si este es el mejor momento para cargar el WS
        self.consultaEstados()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.ocultaPickers()
    }
    func ocultaPickers () {
        var unFrame:CGRect
        unFrame = self.pickerFN.frame
        self.pickerFN.frame = CGRectMake(unFrame.origin.x, CGRectGetMaxY(self.view.frame), unFrame.size.width, unFrame.size.height)
        self.pickerFN.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func consultaEstados() {
        if ConnectionManager.hayConexion() {
            if !ConnectionManager.esConexionWiFi() {
                // Si hay conexion, pero es celular, preguntar al usuario
                // si quiere descargar el contenido
                // ......
                
            }
            let urlString = "http://edg3.mx/webservicessepomex/WMRegresaEstados.php"
            let laURL = NSURL(string: urlString)!
            let elRequest = NSURLRequest(URL: laURL)
            self.datosRecibidos = NSMutableData(capacity: 0)
            self.conexion = NSURLConnection(request: elRequest, delegate: self)
            if self.conexion == nil {
                self.datosRecibidos = nil
                self.conexion = nil
                print ("No se puede acceder al WS Estados")
            }
        }
        else {
            print ("no hay conexion a internet ")
        }
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.datosRecibidos = nil
        self.conexion = nil
        print ("No se puede acceder al WS Estados: Error del server")
    }
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) { // Ya se logrò la conexion, preparando para recibir datos
        self.datosRecibidos?.length = 0
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) { // Se recibiò un paquete de datos. guardarlo con los demàs
        self.datosRecibidos?.appendData(data)
    }
    func connectionDidFinishLoading(connection: NSURLConnection){
        do {
            let arregloRecibido = try NSJSONSerialization.JSONObjectWithData(self.datosRecibidos!, options: .AllowFragments) as! NSArray
            self.estados = arregloRecibido
            self.pickerEstados.reloadAllComponents()
        }
        catch {
            print ("Error al recibir webservice de Estados")
        }
    }
    
    // MARK: - UIPickerView DataSource & Delegate
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // El picker solo tiene un component, entonces "component" no se usa
        if pickerView.isEqual(self.pickerEstados) {
            self.txtEstado.text = (estados![row].valueForKey("nombreEstado") as! String)
            let codigoEstado = (estados![row].valueForKey("c_estado") as! String)
            // Invocar el otro WS para llenar el picker de municipios
            SOAPManager.instance.consultaMunicipios(codigoEstado)
            //selector es el identificador del metodo
            //Nos subcribimos al notification center
            NSNotificationCenter.defaultCenter().addObserver(
                self, selector: #selector(NuevoRViewController.municipiosResponse(_:)),
                name: "WMRegresaMunicipios", object: nil)
            solcecito = LoadingView.loadingInView(self.view, mensaje: "Buscando municipios ...")
            NSNotificationCenter.defaultCenter().addObserver(
                self, selector: #selector(NuevoRViewController.removeSolecito(_:)),
                name: "WMRegresaMunicipiosError", object: nil)
        }
        
    }
    
    func municipiosResponse(notif: NSNotification){
        self.municipios = (notif.userInfo! ["WMRegresaMunicipios"] as! NSArray)
        self.pickerMuns.reloadAllComponents()
        //una vez llegada la notificacion nos des subcribimios con self todas las notificaciones incluso el teclado
        //NSNotificationCenter.defaultCenter().removeObserver(self)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "WMRegresaMunicipios", object: nil)
    }
    
    func removeSolecito(notif: NSNotification) {
        //NSNotificationCenter.defaultCenter().removeObserver(self)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "WMRegresaMunicipiosError", object: nil)
        
        self.solcecito?.performSelector(#selector(LoadingView.removeLoadingInView), withObject: nil, afterDelay: 1.0)
    }
    
}

