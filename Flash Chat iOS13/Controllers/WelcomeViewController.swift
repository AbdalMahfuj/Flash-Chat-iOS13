import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //titleLabel.text = "⚡️FlashChat"
        
        titleLabel.text = ""
        var cc = 0.0
        let titleText = "⚡️FlashChat"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1*cc, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
                //print(0.1*cc," \(letter)")
            }
            cc += 1
        }
        

       
    }
    

}
