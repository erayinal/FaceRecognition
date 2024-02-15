//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Eray İnal on 9.02.2024.
//

import UIKit
import LocalAuthentication //.2

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    

    @IBAction func signInClicked(_ sender: Any) {
        //1 Tuşa basılırsa yüz okumayı aktif hale getirip, çalıştırıcam
        //2 Öncelikle gidip LocalAuthentication import edelim
        
        let authContext = LAContext() //..2
        
        var error : NSError?    //...2 Birazdan bunu fonksiyon içerisinde referans alırken başına '&' iaşreti koymalıyız
        if(authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics , error: &error)){
            //...2 Burada deviceOwnerAuthenticationWithBiometrics seçerek biometrik olarak tanımlama yapmasını istedik, bu yüz okuma da olabilir parkam izi de olabilir telefona göre değişir.
            
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                if success == true{     //3 Eğer tanıma başarılıysa: ikinci ViewController'a git
                    
                    //self.performSegue(withIdentifier: "toSecondVC", sender: nil) //.5 Bu satır değişiklik yapacağımız satır o yüzden yorum satırına alıyorum. Yapılması gereken:
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    } //..5 sadece bu değil 'else' içerisindeki kodu da değiştirmem lazım
                }
                else{ //.3 Eğer tanımlayamıyorsa myLabel'a hata yazdır
                    
                    //self.myLabel.text = "Error!!!"
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!!!"
                    }
                }
            }
            //4 Bunu yapabilmemiz için bir de 'Info' içerisinde '+' tuşuna basarak Privacy - Face ID Usage Description ekleyip açıklama olarak da 'to Authenticate' tarzıdan bir şey yazmalıyız
            
            //5 Buraya kadar yazdıklarımızı çalıştırınca uygulama çöktü çünkü yüz tanımayı arka planda yapmamamız lazım, DispatchQueue olayı devreye giercek. Bu yüzden yukarıdaki bazı satırları değiştirmemiz lazım
            
            
            
        }
        
    }
    
    
}

