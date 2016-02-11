import UIKit

class QuestionWidget: UIView, UITextFieldDelegate {
    
    var question = Question()
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init (question: Question, index: Int) {
        self.init(frame:CGRect.zero)
        setupQuestion(question, index: index)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setupQuestion (question: Question, index: Int){
        
        self.question = question
        
        let captionView = UITextView(frame: CGRect(x: 10, y: index * 50, width: 220, height: 40))
        captionView.font = UIFont.systemFontOfSize(10)
        captionView.text = question.caption
        print("Caption: " + question.caption)
        captionView.editable = false
        addSubview(captionView)
        
        print("datatype: " + question.datatype)
        
        if(question.datatype == "str" || question.datatype == "int"){
            print("Adding!: ")
            let editView = UITextField(frame: CGRect(x: 250, y: index * 50, width: 100, height: 40))
            editView.font = UIFont.systemFontOfSize(10)
            editView.borderStyle = UITextBorderStyle.RoundedRect
            editView.delegate = self
            editView.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            addSubview(editView)
        }
    }
    
    func textFieldDidChange(textField: UITextField) {
        print("change")
        question.answer = textField.text!
    }
}
