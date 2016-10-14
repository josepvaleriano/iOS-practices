//
//  ViewController.h
//  Hello_word
//
//  Created by Infraestructura on 03/09/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

#import <UIKit/UIKit.h>
//extiende de UIViewController
@interface ViewController : UIViewController

//metodo de instancia - o + regresa booleano BOOL
//

- (BOOL) insertUser: (NSString *) nomUsuario
          apellidos: (NSString *) apellidos
               edad: (NSInteger) edad
              email: (NSString *) email;	

@property (weak, nonatomic) IBOutlet UIScrollView *scrllLogin;

// nonaatomic es genra get y set,  weak no es
@property (weak, nonatomic) IBOutlet UITextField *txtNombre;
@property (weak, nonatomic) IBOutlet UITextField *txtApellido;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtEdad;
- (IBAction)tap:(id)sender;



@end

