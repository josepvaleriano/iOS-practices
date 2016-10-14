//
//  ViewController.m
//  Hello_word
//
//  Created by Infraestructura on 03/09/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    BOOL tecladoArriba;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    //solo se ejecuta una sola vez
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // En archivo h es la definiciòn this se utilizara self,   los objetos de manera literal comienza con arroba
    // invocar el metodo corchetes [] en la ejecuciòn 
    [self insertUser: @"Joseluis" apellidos:@"Valeriano"
                edad:42 email:@"jl.val@tx.com"];
    //establecer un tamaño inicial para el contectview, rect es conocer la posiciòn x,y con with and heith
    CGFloat maxY = CGRectGetMaxY(self.txtEdad.frame);
    // bouns son los limites en java objet().tobouns()
    CGFloat ancho = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    CGSize newWidthPantalla = CGSizeMake(ancho, maxY+15.0);
    self.scrllLogin.contentSize = newWidthPantalla;
    //sae encesita que avise el so aparecer teclado notificationcenter
}

- (BOOL) insertUser:(NSString *)nomUsuario apellidos:(NSString *)apellidos edad:(NSInteger)edad email:(NSString *)email{
    // Busca el contexto de la DB
    //crear entitu usuario
    //setear valore
    //guardar contexto
    //Todo bien?
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    
}

- (void)viewWillAppear:(BOOL)animated{
// la vista esta a pnto de aparecer los log no se pone los en liberacion
    NSLog(@"la vista esta a pnto de aparecer los log no se pone los en liberacion");
}

- (void)viewDidAppear:(BOOL)animated{
    
    
    NSLog(@"la vista ya aparecer");
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector: @selector(tecladoAparece:)
     name:UIKeyboardDidShowNotification
     object:nil]; //especifica que cualquier que necesite teclado
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector: @selector(tecladoDesaparece:)
     name:UIKeyboardWillHideNotification
     object:nil]; //especifica que va a teclado
    
    
}

- (void)tecladoAparece: (NSNotification *) laNotificacion{
    if (tecladoArriba)
        return;
    [self ajustaScroll:YES conNotificacion:laNotificacion];
    
}
- (void)tecladoDesaparece: (NSNotification *) laNotificacion{
    
    [self ajustaScroll:NO conNotificacion:laNotificacion];
    
}


    - (void) ajustaScroll: (BOOL) aumenta conNotificacion:
       (NSNotification *) laNotificacion{
    NSDictionary *info = laNotificacion.userInfo;
    NSValue *value = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frameDelTeclado = [value CGRectValue];
    CGSize tamanio = self.scrllLogin.contentSize;
           if (aumenta)
    tamanio.height += frameDelTeclado.size.height;
           else
               tamanio.height -= frameDelTeclado.size.height;
    self.scrllLogin.contentSize = tamanio;
    tecladoArriba = aumenta;
       }


- (void)viewWillDisappear:(BOOL)animated{
// la vista esta a pnto de desaparecer
}



-(void)viewDidDisappear:(BOOL)animated{
    // la vista esta ya desaparecio
}


- (IBAction)tap:(id)sender {
    /*
    //el focus es fearsresponder para indicar que perdio el focus
    if ([self.txtNombre isFirstResponder])
        [self.txtNombre resignFirstResponder];
    if ([self.txtApellido isFirstResponder])
        [self.txtApellido resignFirstResponder];
    if ([self.txtEmail isFirstResponder])
        [self.txtEmail resignFirstResponder];
    if ([self.txtEdad isFirstResponder])
        [self.txtEdad resignFirstResponder];
    */
    /// para optimizar en caso de que hay n elementos
    for (UIView *unView in self.scrllLogin.subviews ) {
        if ([unView isKindOfClass:[UITextField class]]) {
            if ([((UITextField *) unView) isFirstResponder])
                [((UITextField *) unView) resignFirstResponder];
        }
    }
    
    
}
@end





