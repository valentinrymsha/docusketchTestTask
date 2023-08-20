import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var progressImage: UIImageView!
    
    @IBOutlet weak var cellView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0))
    }
}
