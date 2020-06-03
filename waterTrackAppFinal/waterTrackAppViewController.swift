
import UIKit
class waterTrackAppViewController: UIViewController {
    // MARK: - Object
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!    
    @IBOutlet weak var NSConstraint: NSLayoutConstraint!
    // MARK: - Variables & Arrays
    
    let targetValue = 2700
    var addWaterVar = Int()
    let defaults = UserDefaults.standard
    var currentAmount = Int()
    var newAmountVar = Int()
    var storedCurrentAmount = Int()
    var storedAmountGecici = Int()
    var currentDay : Int {
        let dateVar = Date()
        let nowDay = Calendar.current.component(.day, from: dateVar)
        return nowDay
    }
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultAppearance()
        checkDay()
        updateLabel()
        
    }
    // MARK: - Functions
    @IBAction func waterAddButtonClicked(_ sender: Any) {
        addWaterVar = 0
        switch (sender as AnyObject).tag {
        case 1 :
            addWaterVar += 200
        case 2 :
            addWaterVar += 400
        case 3 :
            addWaterVar += 600
        default:
            break
        }
        defaults.set(addWaterVar, forKey: "newAmount")
        saveValuesFunction()
        updateLabel()
    }
    // MARK: - CheckDay Function
    func checkDay () {
        if let latestDayVar = defaults.object(forKey: "latestDay") as? Int {
            if latestDayVar == currentDay {
                print("Aynı gün.")
            }else{
                defaults.set(0, forKey: "currentAmount")
                updateLabel()
            }
        }
    } // MARK: - saveValues Function
    func saveValuesFunction (){
        newAmountVar = defaults.object(forKey: "newAmount") as! Int
        storedCurrentAmount = defaults.object(forKey: "currentAmount") as? Int ?? 0
        storedCurrentAmount = (newAmountVar + storedCurrentAmount)
        defaults.set(storedCurrentAmount, forKey: "currentAmount")
        defaults.set(currentDay, forKey: "latestDay")
    }
    // MARK: - Update Label
    func updateLabel (){
        if let storedAmount = defaults.object(forKey: "currentAmount") as? Int {
            storedAmountGecici = storedAmount
            if storedAmount < 2700 && storedAmount != 0{
                mainLabel.text = "Harika! Bugün su içmişsin."
                subTitleLabel.text = "Bugünkü ihtiyacını karşılamak için \(2700 - storedAmountGecici)Lt. su içmen gerekiyor."
            }else if storedAmount > 2700 {
                mainLabel.text = "Tebrikler! Hedefini tamamladın"
                subTitleLabel.text = "Bugünkü ihtiyacını \(storedAmount)Lt. ile tamamladın."
            }else{
                mainLabel.text = "Merhaba! bugün su içtin mi?"
                subTitleLabel.text = "Bugünkü ihtiyacını karşılamak için 2700 Lt. su içmen gerekiyor."
            }
        }
    }
    // Mark: - UserInterFaceStyle dark - light
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let userInterFaceStyle = traitCollection.userInterfaceStyle
        if userInterFaceStyle == .dark {
            middleButton.backgroundColor = UIColor.white
            rightButton.backgroundColor = UIColor.white
            leftButton.backgroundColor = UIColor.white
        }else{
            middleButton.backgroundColor = UIColor.white
            rightButton.backgroundColor = UIColor.white
            leftButton.backgroundColor = UIColor.white
        }
    }
    func defaultAppearance (){
        middleButton.backgroundColor = UIColor.white
        rightButton.backgroundColor = UIColor.white
        leftButton.backgroundColor = UIColor.white
        middleButton.layer.cornerRadius = 20
        rightButton.layer.cornerRadius = 20
        leftButton.layer.cornerRadius = 20
    }
}
//    func updateWaterLevelFunction(level : Int){
//        let screenheight = Int(view.frame.size.height)
//        let ratio = level / targetValue
//        let calculatedheight = (screenheight * ratio)
////        NSConstraint.constant = CGFloat(calculatedheight)
//        UIViewPropertyAnimator.init(duration: 0.5, dampingRatio: 0.75) {
//            self.view.layoutIfNeeded()
//        }.startAnimation()
//    }
//}
