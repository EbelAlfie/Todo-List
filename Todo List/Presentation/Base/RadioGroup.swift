import UIKit

struct RadioModel<dataType> {
    let label: dataType
    let borderColor: CGColor
}

class RadioGroup {
    private var selection: [RadioModel<String>] = []
    private var buttons: [RadioButton] = []
    
    var selected: RadioModel<String>? = nil
    
    func setOptions(newOption: [RadioModel<String>]) {
        guard !newOption.isEmpty else { return }
        selected = newOption.first
        selection = newOption
    }
    
    func setupView() -> [RadioButton] {
        buttons = selection.map { item in
            self.setupRadioButton(data: item)
        }
        return buttons
    }
    
    private func setupRadioButton(data: RadioModel<String>) -> RadioButton {
        let button = RadioButton(data: data)
        button.layer.borderColor = data.borderColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.setTitle(data.label, for: .normal)
        button.bounds = CGRect(x: 0, y: 0, width: button.bounds.width + 10, height: button.bounds.height + 10)
        button.addTarget(self, action: #selector(onSelected(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func onSelected(_ sender : RadioButton) {
        for button in buttons {
            button.backgroundColor = .clear
            button.setTitleColor(.white, for: .normal)
        }
        selected = sender.data
        sender.layer.backgroundColor = sender.data.borderColor
        sender.setTitleColor(.black, for: .normal)
    }
}
