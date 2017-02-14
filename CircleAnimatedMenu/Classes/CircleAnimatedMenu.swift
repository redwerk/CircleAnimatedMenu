//
//  CircleAnimatedMenu.swift
//  Pods
//
//  Created by Alexandr Honcharenko on 2/2/17.
//
//

import Foundation

@IBDesignable open class CircleAnimatedMenu: UIControl {
    
    // MARK: - Public properties
    
    // Inner radius of menu
    @IBInspectable public var innerRadius: CGFloat = 30 {
        didSet {
            var maxInnerRadius = self.frame.size.height > self.frame.size.width - imageSize ?
            self.frame.size.width / 2  - 20 : self.frame.size.height / 2 - 20
            innerRadius = innerRadius > maxInnerRadius ? maxInnerRadius : innerRadius
            update()
        }
    }
    
    // Outer radius of menu
    @IBInspectable public var outerRadius: CGFloat = 75 {
        didSet {
            var maxOuterRadius = self.frame.size.height > self.frame.size.width ? self.frame.size.width / 2 : self.frame.size.height / 2
            outerRadius = outerRadius > maxOuterRadius ? maxOuterRadius : outerRadius
            update()
        }
    }
    
    // Width of line between sections and central circle
    @IBInspectable public var closerBorderWidth: CGFloat = 2 {
        didSet {
            update()
        }
    }
    
    // Width of border menu
    @IBInspectable public var farBorderWidth: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    // Menu fill color
    @IBInspectable public var menuFillColor: UIColor = .darkGray {
        didSet {
            update()
        }
    }
    
    // Menu background color - color of layer that lies under section layers and inner circle layer
    @IBInspectable public var menuBackgroundColor: UIColor = .white {
        didSet {
            update()
        }
    }
    
    // Inner circle color
    @IBInspectable public var innerCircleColor: UIColor = .darkGray {
        didSet {
            update()
        }
    }
    
    // Color of section after selection
    @IBInspectable public var highlightedColor: UIColor = .blue {
        didSet {
            update()
        }
    }
    
    // Color of line between slices and central circle
    @IBInspectable public var closerBorderColor: UIColor = .white {
        didSet {
            update()
        }
    }
    
    // Border menu color
    @IBInspectable public var farBorderColor: UIColor = .white {
        didSet {
            update()
        }
    }
    
    // Sections stroke color
    @IBInspectable public var sectionsStrokeColor: UIColor = .white {
        didSet {
            update()
        }
    }
    
    // Text color
    @IBInspectable public var textColor: UIColor = .white {
        didSet {
            update()
        }
    }
    
    // Shadow color
    @IBInspectable public var shadowColor: UIColor = .lightGray {
        didSet {
            update()
        }
    }
    
    // Shadow radius
    @IBInspectable public var menuShadowRadius: CGFloat = 15 {
        didSet {
            update()
        }
    }
    
    // Duration it takes to sections to expand
    public var animDuration: Double = 1.0 {
        didSet {
            update()
        }
    }
    
    // Menu width line
    @IBInspectable public var menuWidthLine: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    // Text font size
    @IBInspectable public var titleFontSize: CGFloat = 13 {
        didSet {
            update()
        }
    }
    
    // Image size value
    public var imageSize: CGFloat = 30 {
        didSet {
            update()
        }
    }
    
    // Default highlighted section index. Set it if you want to highlight some section at start
    @IBInspectable public var defaulHighlightedtSectionIndex: Int = -1 {
        didSet {
            update()
        }
    }
    
    // Delegate
    public weak var delegate: CircleAnimatedMenuDelegate?
    
    // set animation state. Default - true
    public var animated: Bool = true {
        didSet {
            update()
        }
    }
    
    // Data
    public var dataTuple: [(String, String)] = [] {
        didSet {
            update()
        }
    }
    
    // You can set highlighted colors array if you want to highlight each section separately
    public var highlightedColors: [UIColor] = [] {
        didSet {
            update()
        }
    }
    
    // MARK: - Privete properties
    
    var sectionLayers: [CAShapeLayer] = []
    var imageLayers: [CALayer] = []
    var mainCircleLayer = CAShapeLayer()
    var borderCircleLayer = CAShapeLayer()
    var textCircleLayer = CAShapeLayer()
    var textLayer = CATextLayer()
    var selectedSectionIndex: Int = 0
    var previousIndexes: [Int] = []
    
    var startAngle:CGFloat = 0.0
    var endAngle:CGFloat = 0.0
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(menuFrame: CGRect, dataArray: [(String, String)]) {
        
        dataTuple = dataArray
        super.init(frame: menuFrame)
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognized(gesture:)))
        self.addGestureRecognizer(gestureRecognizer)
        update()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        update()
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognized(gesture:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: - UpdatingUI
    
    func updateUI() {
        
        setInitialValues()
        
        sectionLayers.removeAll()
        let center: CGPoint = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        // init mainCircleLayer
        mainCircleLayer = CAShapeLayer()
        let mainCirclePath = UIBezierPath(ovalIn: CGRect(x: center.x - outerRadius, y: center.y - outerRadius,
                                                     width: 2 * outerRadius, height: 2 * outerRadius))
        mainCircleLayer.fillColor = UIColor.clear.cgColor
        mainCircleLayer.lineWidth = farBorderWidth
        mainCircleLayer.strokeColor = UIColor.clear.cgColor
        mainCircleLayer.path = mainCirclePath.cgPath
        self.layer.addSublayer(mainCircleLayer)
        
        // init borderCircleLayer - mask layer to draw border
        borderCircleLayer = CAShapeLayer()
        let borderCirclePath = UIBezierPath(ovalIn: CGRect(x: center.x - outerRadius, y: center.y - outerRadius,
                                                          width: 2 * outerRadius, height: 2 * outerRadius))
        borderCircleLayer.fillColor = UIColor.clear.cgColor
        borderCircleLayer.lineWidth = farBorderWidth
        borderCircleLayer.strokeColor = UIColor.clear.cgColor
        borderCircleLayer.path = borderCirclePath.cgPath
        
        let width : CGFloat =  1 / CGFloat(dataTuple.count)
        let imageRadius = ((outerRadius - innerRadius) / 2) + innerRadius
        for (index, value) in dataTuple.enumerated() {
            
            // init sectionLayer
            var sectionLayer = CAShapeLayer()
            sectionLayer.fillColor = menuFillColor.cgColor
            sectionLayer.strokeColor = sectionsStrokeColor.cgColor
            sectionLayer.lineWidth = menuWidthLine
            let path = UIBezierPath()
            path.move(to: center)
            endAngle = startAngle + width * CGFloat(M_PI) * 2.0
            path.addArc(withCenter: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: center)
            path.close()
            sectionLayer.path = path.cgPath
            
            // init imageLayer - layer inside sectionLayer which contains image
            let middleEndAngle:CGFloat = startAngle + width / 2 * CGFloat(M_PI) * 2.0
            let imageLayer = CALayer()
            let image = UIImage(named: value.0)
            imageLayer.contents = image?.cgImage
            let imageX = (imageRadius * cos(middleEndAngle)) + center.x - imageSize / 2
            let imageY = (imageRadius * sin(middleEndAngle)) + center.y - imageSize / 2
            imageLayer.frame = CGRect(x: imageX, y: imageY, width: imageSize, height: imageSize)
            sectionLayer.contentsGravity = kCAGravityResizeAspect
            imageLayer.mask = sectionLayer
            imageLayers.append(imageLayer)
            
            // add sectionLayer to array
            sectionLayers.append(sectionLayer)
            
            // add animation to sectionLayer
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = animDuration
            let initialPath = UIBezierPath()
            initialPath.move(to: center)
            initialPath.addArc(withCenter: center, radius: 1, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            initialPath.addLine(to: center)
            initialPath.close()
            animation.fromValue = initialPath.cgPath
            animation.toValue = sectionLayer.path
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.setValue(index, forKey: "id")
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            if animated {
                animation.delegate = self
                sectionLayer.add(animation, forKey: String(index))
            }

            // change start angle
            startAngle = endAngle
        }
        
        // init textCircleLayer - circle layer which shows title of each section
        textCircleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(ovalIn: CGRect(x: center.x - innerRadius, y: center.y - innerRadius,
                                                             width: 2 * innerRadius, height: 2 * innerRadius))
        textCircleLayer.fillColor = innerCircleColor.cgColor
        textCircleLayer.strokeColor = closerBorderColor.cgColor
        textCircleLayer.lineWidth = closerBorderWidth
        textCircleLayer.path = circlePath.cgPath
        
        // init textLayer - special layer to show text
        textLayer = CATextLayer()
        textLayer.frame = CGRect(x: center.x - innerRadius + 4, y: center.y - titleFontSize / 2, width: 2 * innerRadius - 8, height: titleFontSize + 4)
        textLayer.fontSize = titleFontSize
        textLayer.foregroundColor = textColor.cgColor
        textLayer.backgroundColor = innerCircleColor.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.isWrapped = true
        textLayer.truncationMode = kCATruncationEnd
        textLayer.string = ""
        
        self.setNeedsLayout()
    }
    
    fileprivate func highlightDefaultSection() {
        var highlightedSecttion = sectionLayers[defaulHighlightedtSectionIndex]
        highlightedSecttion.fillColor = highlightedColor.cgColor
        textLayer.string = dataTuple[defaulHighlightedtSectionIndex].1
    }
    
    fileprivate func showSlices() {
        for sectionLayer in sectionLayers {
            self.layer.addSublayer(sectionLayer)
            if !animated {
                var imageLayerIndex = sectionLayers.index(of: sectionLayer)
                sectionLayer.addSublayer(imageLayers[imageLayerIndex!])
            }
        }
        if (!animated) {
            setStateAfterAnimation()
        }
    }
    
    // MARK: - Handle Touches
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        let touchPoint = touch.location(in: self)
        for var shapeLayer in sectionLayers {
            let currentIndex = sectionLayers.index(of: shapeLayer)!
            if ((shapeLayer.path?.contains(touchPoint))! && !(textCircleLayer.path?.contains(touchPoint))!) {
                if highlightedColors.isEmpty {
                    shapeLayer.fillColor = highlightedColor.cgColor
                } else {
                    shapeLayer.fillColor = highlightedColors[0].cgColor
                }
                selectedSectionIndex = currentIndex
                let currentText = dataTuple[selectedSectionIndex].1
                textLayer.string = currentText
            }
        }
        
        return true
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        clearData()
        delegate?.sectionSelected(text: dataTuple[selectedSectionIndex].1, index: selectedSectionIndex)
    }
    
    // MARK: - UIPanGestureRecognizer methods
    
    func gestureRecognized(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            let location = gesture.location(in: self)
            fillSectionIn(location: location)
            
        case .changed:
            let location = gesture.location(in: self)
            fillSectionIn(location: location)
            
        case .ended:
            clearData()
            delegate?.sectionSelected(text: dataTuple[selectedSectionIndex].1, index: selectedSectionIndex)
        default:
            print("default")
        }
        
    }
    
    // MARK: - Helpers
    
    func fillSectionIn(location: CGPoint) {
        for var shapeLayer in sectionLayers {
            shapeLayer.fillColor = menuFillColor.cgColor
            let currentIndex = sectionLayers.index(of: shapeLayer)!
            if ((shapeLayer.path?.contains(location))! && !(textCircleLayer.path?.contains(location))!) {
                if !previousIndexes.contains(currentIndex) {
                    selectedSectionIndex = currentIndex
                    previousIndexes.insert(selectedSectionIndex, at: 0)
                    let currentText = dataTuple[selectedSectionIndex].1
                    textLayer.string = currentText
                } else {
                    var previousIndex = previousIndexes.index(of: currentIndex)
                    if previousIndex == 1 {
                        selectedSectionIndex = currentIndex
                        let currentText = dataTuple[selectedSectionIndex].1
                        textLayer.string = currentText
                        var firstElement = previousIndexes.first
                        previousIndexes.removeAll()
                        previousIndexes.append(currentIndex)
                        previousIndexes.append(firstElement!)
                    }
                }
                if previousIndexes.count == 1 {
                    if highlightedColors.isEmpty {
                        shapeLayer.fillColor = highlightedColor.cgColor
                    } else {
                        shapeLayer.fillColor = highlightedColors[0].cgColor
                    }
                } else if previousIndexes.count == 7 || previousIndexes.count == sectionLayers.count {
                    previousIndexes.removeLast()
                }
                
            }
            if previousIndexes.count > 1 {
                if previousIndexes.contains(currentIndex) {
                    if highlightedColors.isEmpty {
                        let previousIndex = previousIndexes.index(of: currentIndex)
                        let currentAlpha = 1 - (Double(previousIndex!) * 0.15)
                        let newHighlightedColor: UIColor = highlightedColor.withAlphaComponent(CGFloat(currentAlpha))
                        shapeLayer.fillColor = newHighlightedColor.cgColor
                    } else {
                        let previousIndex = previousIndexes.index(of: currentIndex)
                        if previousIndex! < highlightedColors.count {
                            shapeLayer.fillColor = highlightedColors[previousIndex!].cgColor
                        }
                    }
                }
            }
        }
    }
    
    func clearData() {
        for var shapeLayer in sectionLayers {
            shapeLayer.fillColor = menuFillColor.cgColor
        }
        if highlightedColors.isEmpty {
            sectionLayers[selectedSectionIndex].fillColor = highlightedColor.cgColor
        } else {
            sectionLayers[selectedSectionIndex].fillColor = highlightedColors[0].cgColor
        }
        previousIndexes.removeAll()
    }
    
    func update() {
        updateUI()
        showSlices()
    }
    
    func setInitialValues() {
        
        sectionLayers = [CAShapeLayer]()
        imageLayers = [CALayer]()
        mainCircleLayer.fillColor = UIColor.clear.cgColor
        borderCircleLayer.fillColor = UIColor.clear.cgColor
        borderCircleLayer.strokeColor = UIColor.clear.cgColor
        textCircleLayer.fillColor = UIColor.clear.cgColor
        textLayer.foregroundColor = UIColor.clear.cgColor
        previousIndexes = []
        startAngle = 0.0
        endAngle = 0.0
    }
    
    func setStateAfterAnimation() {
        mainCircleLayer.strokeColor = farBorderColor.cgColor
        mainCircleLayer.fillColor = menuBackgroundColor.cgColor
        borderCircleLayer.strokeColor = farBorderColor.cgColor
        self.layer.addSublayer(textCircleLayer)
        textCircleLayer.addSublayer(borderCircleLayer)
        textCircleLayer.addSublayer(textLayer)
        mainCircleLayer.shadowRadius = menuShadowRadius
        mainCircleLayer.shadowOffset = CGSize(width: 0, height: 0)
        mainCircleLayer.shadowColor = shadowColor.cgColor
        mainCircleLayer.shadowOpacity = 0.8
        if defaulHighlightedtSectionIndex > 0 {
            highlightDefaultSection()
        }
    }
    
}

extension CircleAnimatedMenu: CAAnimationDelegate {
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim.value(forKey: "id") as! Int == sectionLayers.count - 1 {
            for sectionLayer in sectionLayers {
                var imageLayerIndex = sectionLayers.index(of: sectionLayer)
                imageLayers[imageLayerIndex!].removeFromSuperlayer()
                sectionLayer.addSublayer(imageLayers[imageLayerIndex!])
            }
            setStateAfterAnimation()
        }
    }
    
}
