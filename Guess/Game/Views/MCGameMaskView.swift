//
//  MCGameMaskView.swift
//  Guess
//
//  Created by MingleChang on 2020/1/3.
//  Copyright © 2020 MingleChang. All rights reserved.
//

import UIKit

class MCGameMaskView: UIView , CAAnimationDelegate{
    var startCallBack: MCVoidCallBack?
    
    private var count: Int = 3
    private let circleShapeLayer: CAShapeLayer = CAShapeLayer()
    private let textLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let lWidth = frame.size.width
        let lHeight = frame.size.height
        let lRadius = min(lWidth, lHeight) / 2 - CGFloat(MCPixelRatio(50))
        let lStartAngle = -Double.pi / 2
        let lEndAngle = lStartAngle + Double.pi * 2
        let lPath = UIBezierPath(arcCenter: center, radius: lRadius, startAngle: CGFloat(lStartAngle), endAngle: CGFloat(lEndAngle), clockwise: true)
        circleShapeLayer.path = lPath.cgPath
    }
}
// MARK: - Public
extension MCGameMaskView {
    func startCountDown() {
        startCountDown(callBack: nil)
    }
    func startCountDown(callBack: MCVoidCallBack?) {
        startCallBack = callBack
        resetUI()
        count = 3
        countDownAnimation()
    }
    func rightThis() {
        rightThis(callBack: nil)
    }
    func rightThis(callBack: MCVoidCallBack?) {
        resetUI()
        backgroundColor = UIColor(named: "Success")
        textLabel.text = MCLocalized("Right")
        dismiss(callBack: callBack)
    }
    func skipNext() {
        skipNext(callBack: nil)
    }
    func skipNext(callBack: MCVoidCallBack?) {
        resetUI()
        backgroundColor = UIColor(named: "Error")
        textLabel.text = MCLocalized("Skip")
        dismiss(callBack: callBack)
    }
}
// MARK: - Private
extension MCGameMaskView {
    func countDownAnimation() {
        textLabel.text = String(count)
        circleShapeLayer.strokeStart = 0
        circleShapeLayer.strokeEnd = 1.0
        if count == 0 {
            dismiss(callBack: startCallBack)
            startCallBack = nil
            return
        }
        let lAnimation = CABasicAnimation(keyPath: "strokeEnd")
        lAnimation.fromValue = 1.0
        lAnimation.toValue = 0.0
        lAnimation.duration = 1.5
        lAnimation.delegate = self
        circleShapeLayer.add(lAnimation, forKey: "strokeEnd")
    }
    func resetUI() {
        
        circleShapeLayer.strokeStart = 0
        circleShapeLayer.strokeEnd = 1.0
        isHidden = false
        alpha = 1.0
    }
    func dismiss() {
        dismiss(callBack: nil)
    }
    func dismiss(callBack: MCVoidCallBack?) {
        UIView.animate(withDuration: 0.5, animations: {[unowned self] in
            self.alpha = 0.0
        }) {[unowned self] (finished) in
            self.isHidden = true
            if (callBack != nil) {
                callBack!()
            }
        }
    }
}
// MARK: - Delegate
// MARK: - CAAnimationDelegate
extension MCGameMaskView {
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        count = count - 1
        countDownAnimation()
    }
}
// MARK: - Configure
extension MCGameMaskView {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
        backgroundColor = UIColor(named: "Warning")
        
        circleShapeLayer.strokeColor = UIColor.white.cgColor
        circleShapeLayer.fillColor =  UIColor.clear.cgColor
        circleShapeLayer.lineWidth = CGFloat(MCPixelRatio(10))
        layer.addSublayer(circleShapeLayer)
        
        textLabel.textColor = UIColor.white
        textLabel.text = "3"
        textLabel.font = MCMarkerFeltWideFont(50)
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    func configureData() {
        let animation = CABasicAnimation()
        animation.delegate = self
    }
}
