import UIKit

class RadioButton: UIButton {
    let data: RadioModel<String>
    
    init(data: RadioModel<String>) {
        self.data = data
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
