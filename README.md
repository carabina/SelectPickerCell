# SelectPickerCell

<p align="center">
<img src="https://dl.dropbox.com/s/q7f7v7kk90f3xhe/selectpickercell.gif" style="width:400px;"/>
</p>



Inline/Expanding UIPicker for table views.

## Installation

SelectPickerCell is available through [CocoaPods](http://cocoapods.org). To install
it, add it to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'SelectPickerCell'
```

##Usage

An example of programmatically creating a tableview with one SelectPickerCell.

```swift
import UIKit
import SelectPickerCell

class TableViewController: UITableViewController {
    
    var selectCell = SelectPickerCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectCell.leftLabel.text = "Fruit Options"
        selectCell.options = ["Apple", "Orange", "Pear"]
        selectCell.selectedOption = "Pear"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return selectCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return selectCell.selectPickerHeight()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCell.selectedInTableView(tableView)
    }
}
```

## Author

Phong Le, phong@oclef.com

Credit to Dylan Vann whose DatePickerCell is the basis of SelectPickerCell

## License

SelectPickerCell is available under the MIT license. See the LICENSE file for more info.
