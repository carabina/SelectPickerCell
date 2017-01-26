//
//  SelectPickerCell.swift
//  Oclef
//
//  Created by Phong Quoc Le on 1/24/17.
//  Copyright © 2017 Oclef. All rights reserved.
//

import Foundation
import UIKit

/**
 *  Inline/Expanding date picker for table views.
 */

/**
 *  Optional protocol called when option is picked
 */
@objc public protocol SelectPickerCellDelegate {
    @objc optional func selectPickerCell(_ cell: SelectPickerCell, didPickRow row: Int)
}

extension SelectPickerCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.options.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.options[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.rightLabel.text = self.options[row];
        self.delegate?.selectPickerCell?(self, didPickRow: row)
    }
}

open class SelectPickerCell: UITableViewCell {
    
    /**
     *  UIView subclass. Used as a subview in UITableViewCells. Does not change color when the UITableViewCell is selected.
     */
    
    // delegate
    open var delegate: SelectPickerCellDelegate?
    
    class DVColorLockView:UIView {
        
        var lockedBackgroundColor:UIColor {
            set {
                super.backgroundColor = newValue
            }
            get {
                return super.backgroundColor!
            }
        }
        
        override var backgroundColor:UIColor? {
            set {
            }
            get {
                return super.backgroundColor
            }
        }
    }
    
    /// The selected option
    open var selectedOption:String = "" {
        didSet {
            let index = self.options.index(of: selectedOption)
            if index != nil {
                selectPicker.selectRow(index!, inComponent: 0, animated: false)
                rightLabel.text = selectedOption
            }
            
        }
    }
    
    /// The options in the UIPicker
    open var options:[String] = [String]() {
        didSet {
            self.selectPicker.reloadComponent(0);
        }
    }
    
    /// Label on the left side of the cell.
    open var leftLabel = UILabel()
    /// Label on the right side of the cell.
    open var rightLabel = UILabel()
    /// Color of the right label. Default is the color of a normal detail label.
    open var rightLabelTextColor = UIColor(hue: 0.639, saturation: 0.041, brightness: 0.576, alpha: 1.0) {
        didSet {
            rightLabel.textColor = rightLabelTextColor
        }
    }
    
    var seperator = DVColorLockView()
    
    var selectPickerContainer = UIView()
    open var selectPicker: UIPickerView = UIPickerView()
    
    /// Is the cell expanded?
    open var expanded = false
    var unexpandedHeight = CGFloat(44)
    
    /**
     Creates the SelectPickerCell
     
     - parameter style:           A constant indicating a cell style. See UITableViewCellStyle for descriptions of these constants.
     - parameter reuseIdentifier: A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view. Pass nil if the cell object is not to be reused. You should use the same reuse identifier for all cells of the same form.
     
     - returns: An initialized SelectPickerCell object or nil if the object could not be created.
     */
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    fileprivate func setup() {
        
        self.clipsToBounds = true
        
        let views = [leftLabel, rightLabel, seperator, selectPickerContainer, selectPicker]
        for view in views {
            self.contentView .addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        selectPicker.delegate = self;
        
        selectPickerContainer.clipsToBounds = true
        selectPickerContainer.addSubview(selectPicker)
        
        // Add a seperator between the date text display, and the selectPicker. Lighter grey than a normal seperator.
        seperator.lockedBackgroundColor = UIColor(white: 0, alpha: 0.1)
        selectPickerContainer.addSubview(seperator)
        selectPickerContainer.addConstraints([
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.left,
                relatedBy: NSLayoutRelation.equal,
                toItem: selectPickerContainer,
                attribute: NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.right,
                relatedBy: NSLayoutRelation.equal,
                toItem: selectPickerContainer,
                attribute: NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1.0,
                constant: 0.5
            ),
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: selectPickerContainer,
                attribute: NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            ])
        
        
        rightLabel.textColor = rightLabelTextColor
        
        // Left label.
        self.contentView.addConstraints([
            NSLayoutConstraint(
                item: leftLabel,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1.0,
                constant: 44
            ),
            NSLayoutConstraint(
                item: leftLabel,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: leftLabel,
                attribute: NSLayoutAttribute.left,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: self.separatorInset.left
            ),
            ])
        
        // Right label
        self.contentView.addConstraints([
            NSLayoutConstraint(
                item: rightLabel,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1.0,
                constant: 44
            ),
            NSLayoutConstraint(
                item: rightLabel,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: rightLabel,
                attribute: NSLayoutAttribute.right,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: -self.separatorInset.left
            ),
            ])
        
        // Container.
        self.contentView.addConstraints([
            NSLayoutConstraint(
                item: selectPickerContainer,
                attribute: NSLayoutAttribute.left,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: selectPickerContainer,
                attribute: NSLayoutAttribute.right,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: selectPickerContainer,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: leftLabel,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: selectPickerContainer,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: NSLayoutRelation.equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: 1
            ),
            ])
        
        // Picker constraints.
        selectPickerContainer.addConstraints([
            NSLayoutConstraint(
                item: selectPicker,
                attribute: NSLayoutAttribute.left,
                relatedBy: NSLayoutRelation.equal,
                toItem: selectPickerContainer,
                attribute: NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: selectPicker,
                attribute: NSLayoutAttribute.right,
                relatedBy: NSLayoutRelation.equal,
                toItem: selectPickerContainer,
                attribute: NSLayoutAttribute.right,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: selectPicker,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: selectPickerContainer,
                attribute: NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: 0
            ),
            ])
        
        if self.options.count > 0 {
            self.selectedOption = self.options[0]
        }
        
        leftLabel.text = ""
    }
    
    /**
     Needed for initialization from a storyboard.
     
     - parameter aDecoder: An unarchiver object.
     - returns: An initialized DatePickerCell object or nil if the object could not be created.
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /**
     Determines the current desired height of the cell. Used in the UITableViewDelegate's heightForRowAtIndexPath method.
     
     - returns: The cell's height.
     */
    open func selectPickerHeight() -> CGFloat {
        let expandedHeight = unexpandedHeight + CGFloat(selectPicker.frame.size.height)
        return expanded ? expandedHeight : unexpandedHeight
    }
    
    /**
     Used to notify the SelectPickerCell that it was selected. The SelectPickerCell will then run its selection animation and expand or collapse.
     
     - parameter tableView: The tableview the SelectPickerCell was selected in.
     */
    open func selectedInTableView(_ tableView: UITableView) {
        expanded = !expanded
        
        UIView.transition(with: rightLabel, duration: 0.25, options:UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
            self.rightLabel.textColor = self.expanded ? self.tintColor : self.rightLabelTextColor
        }, completion: nil)
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
