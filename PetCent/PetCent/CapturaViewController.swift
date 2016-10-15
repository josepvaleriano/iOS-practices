//
//  CapturaViewController.swift
//  PetCent
//
//  Created by Infraestructura on 15/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class CapturaViewController: UIViewController, UITextFieldDelegate,
UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtFechaNacimiento: UITextField!
    @IBOutlet weak var txtCalle: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    @IBOutlet weak var txtApellidos: UITextField!
    @IBOutlet weak var txtColonia: UITextField!
    @IBOutlet weak var txtMunicipio: UITextField!
    @IBOutlet weak var pickerFechaNacimiento: UIDatePicker!
    @IBOutlet weak var pickerEdos: UIPickerView!
    @IBOutlet weak var pickerMun: UIPickerView!
    @IBOutlet weak var pickerCols: UIPickerView!
    
    var estados: NSArray?
    var municipios :NSArray?
    var colonias: NSArray?
    var conexion: NSURLConnection?
    var datosRecibidos: NSMutableData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtNombre.delegate = self
        self.txtFechaNacimiento.delegate = self
        self.txtCalle.delegate = self
        self.txtEstado.delegate = self
        self.txtApellidos.delegate = self
        self.txtColonia.delegate = self
        self.txtMunicipio.delegate = self
        self.pickerFechaNacimiento.hidden = true

        // Do any additional setup after loading the view.
        // se inicializa los arreglos para que no cracs los combos
        self.pickerEdos.delegate = self
        self.estados = NSArray()
        self.municipios = ["datos 1"," jhon","doe"] // NSArray()
        //tarea inicializar con arreglo de cualqueir cosa tipo json
        self.colonias =  ["tequila"," mezcal","jarana"] //NSArray()ΩNSArray()
        self.consultaEstados()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ocultaPickers()
    }
    @IBAction func pickerDateChang(sender: AnyObject) {
        // se crea el tipo date , se da formato y se asocia al txtrFN
        let formato = NSDateFormatter()
        formato.dateFormat = "dd-MMM-yyyy"
        let fechaString = formato.stringFromDate(self.pickerFechaNacimiento.date)
        self.txtFechaNacimiento.text = fechaString
        
    }
    
    func subeBajaPicker (elPicker:UIView, subeOBaja:Bool){
        var elFrame:CGRect = elPicker.frame
        UIView.animateWithDuration(2.5, animations: {
            if subeOBaja {
                elFrame.origin.y = CGRectGetMaxY(self.txtFechaNacimiento.frame)
                elPicker.hidden = false
            }
            else{
                elFrame.origin.y = CGRectGetMaxY(self.view.frame)
            }
        })
        elPicker.frame = elFrame
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        // Se va a deshabilitar los pikers así que solo se validan los inputs
        if textField.isEqual(self.txtNombre) || textField.isEqual(self.txtCalle)
            || textField.isEqual(self.txtApellidos) {
            ocultaPickers()
            return true
        }
        else{
            self.txtNombre.resignFirstResponder()
            self.txtCalle.resignFirstResponder()
            self.txtApellidos.resignFirstResponder()
            if textField.isEqual(txtFechaNacimiento){
                // se realiza un cas
                subeBajaPicker(self.pickerFechaNacimiento, subeOBaja: true)
                
            }
        }
        return false
    }
    

    
    
    func ocultaPickers(){
        var unFrame:CGRect
        unFrame = self.pickerFechaNacimiento.frame
        // pone el picker al lado del txtfecha
        self.pickerFechaNacimiento.frame = CGRectMake(unFrame.origin.x, CGRectGetMinY(self.view.frame), unFrame.size.width, unFrame.size.height)
        self.pickerFechaNacimiento.hidden = true
    }
    // el web service es asincrono por que no se sabe el tiempo de respuesta
    func consultaEstados(){
        let urlString = "http://edg3.mx/webservicessepomex/WMRegresaEstados.php"
        let laUrl = NSURL(string:urlString)!
        let elRequest = NSURLRequest(URL: laUrl)
        self.datosRecibidos = NSMutableData(capacity:0)
        self.conexion = NSURLConnection(request: elRequest, delegate: self)
        if self.conexion == nil{
            self.datosRecibidos = nil
            self.conexion = nil
            print("No se puede acceder al Ws Estados")
            
        }
        else{
            
        }
    }
    // en automatico ejeecuta este cuando se ejecuta  self.conexion = NSURLConnection(request: elRequest, delegate: self)
    func connection(connection: NSURLConnection, didFailWithError error: NSError){
        self.datosRecibidos = nil
        self.conexion = nil
        print("Sin conexion")
    }
    // en automatico ejecuta este cuando responde la  self.conexion
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        
    }
    // en automatico ejecuta este cuando se esta recibiendo datos
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        //la operación de datos se debe agregar en paquetes para toda la transmisión
        self.datosRecibidos?.appendData(data)
        
    }
    
    // cuando termina la petision
    func connectionDidFinishLoading(connection: NSURLConnection){
        // el arreglo de betyys se convierte a arreglo de json
        do{
            // requiero que devuelva un objeto json a partir de datos
            //allowFragments es convertir los datos recibidos {"",""}, {""
            //muta lecontainer  se convierte a nsdictionary  que el contendoer sea mutalble
            //para solo lectura allowfragments, los otros dos son para manipoular datos
            let arregloRecibido = try NSJSONSerialization.JSONObjectWithData(datosRecibidos!, options: .AllowFragments) as! NSArray
            self.estados = arregloRecibido
            self.pickerEdos.reloadAllComponents()
        }catch{
            print("Conection to traslate data to json")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (pickerView.isEqual(self.pickerEdos)){
            return self.estados!.count
        }
        else if (pickerView.isEqual(self.pickerMun)){
            return self.municipios!.count
        }
        else {
            return self.colonias!.count
        }
        
    }
    
    // se debe
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if (pickerView.isEqual(self.pickerEdos)){
            return (self.estados![row].valueForKey("nombreEstado") as! String)
        }
        else if (pickerView.isEqual(self.pickerMun)){
            return (self.municipios![row] as! String)
        }
        else {
            return (self.colonias![row] as! String)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}








