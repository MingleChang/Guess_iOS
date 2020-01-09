//
//  MCGameController.swift
//  Guess
//
//  Created by MingleChang on 2020/1/2.
//  Copyright © 2020 MingleChang. All rights reserved.
//

import UIKit
import CoreMotion


class MCGameController: MCViewController {
    private let motionManager: CMMotionManager = CMMotionManager()
    private let textLabel: UILabel = UILabel()
    private let progressView: UIProgressView = UIProgressView()
    private let timeLabel: UILabel = UILabel()
    private let leftControl: UIControl = UIControl()
    private let rightControl: UIControl = UIControl()
    private let maskView: MCGameMaskView = MCGameMaskView()
    
    private var timer: Timer?
    
    private var status: MCWordResult = .right
    
    private var wordIndex: Int = 0
    var words: [MCWordModel] = []
    var timeTotal: Int = 0
    var timeCount: Int = 0
    
    var completeWords: [MCWordModel] = []
    
    var currentWord: MCWordModel {
        get {
            return words[wordIndex]
        }
    }
    
    deinit {
        stopTimer()
    }
    private let navigationBar: MCNavigationBar = MCNavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        maskView.startCountDown {[unowned self] () -> (Void) in
            self.gameStart()
        }
    }
}
// MARK: - Private
extension MCGameController {
    func completionCurrentWord(result: MCWordResult) {
        var lWord = currentWord
        lWord.resutlt = result
        completeWords.append(lWord)
    }
    func resetTimerDisplay() {
        timeLabel.text = MCFormatTimeCount(timeCount)
        let lProgress = Float(timeCount) / Float(timeTotal)
        progressView.setProgress(lProgress, animated: true)
    }
    func resetCurrentWord() {
        if wordIndex >= words.count {
            gameOver()
            return
        }
        textLabel.text = currentWord.word
    }
    func rightCurrentWord() {
        maskView.rightThis()
        completionCurrentWord(result: .right)
        wordIndex = wordIndex + 1
        resetCurrentWord()
    }
    func skipCurrentWord() {
        maskView.skipNext()
        completionCurrentWord(result: .skip)
        wordIndex = wordIndex + 1
        resetCurrentWord()
    }
    func gameStart() {
        MCLog("gameStart")
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            let value = data?.acceleration.z ?? 0
            if (value > -0.2 && value < 0.2 && self.status != .normal) {
                self.status = .normal
            }else if (self.status != .normal) {
                
            }else if (value <= -0.5) {
                self.status = .skip
                self.skipCurrentWord()
            }else if (value > 0.5) {
                self.status = .right
                self.rightCurrentWord()
            }
        }
        self.startTimer()
        
    }
    func gameOver() {
        motionManager.stopAccelerometerUpdates()
        stopTimer()
        rightControl.isEnabled = false
        leftControl.isEnabled = false
        MCLog("Game Over")
        let lViewController = MCResultController()
        MCLog(completeWords)
        navigationController?.pushViewController(lViewController, animated: true)
    }
}
// MARK: - Timer
extension MCGameController {
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {[weak self] (timer) in
            self?.timerUpdate(timer)
        })
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    @objc func timerUpdate(_ sender: Timer) {
        timeCount = timeCount - 1
        resetTimerDisplay()
        if (timeCount<=0) {
            completionCurrentWord(result: .timeout)
            gameOver()
        }
    }
}
// MARK: - Event Response
extension MCGameController {
    @objc func rightControlClick(_ sender: UIControl) {
        rightCurrentWord()
    }
    @objc func leftControlClick(_ sender: UIControl) {
        skipCurrentWord()
    }
}
// MARK: - Configure
extension MCGameController {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
        textLabel.textColor = UIColor.white
        textLabel.font = MCMarkerFeltWideFont(40)
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let progressHeight = MCPixelRatio(14)
        progressView.progress = 1.0
        progressView.progressTintColor = UIColor(named: "Warning")
        progressView.trackTintColor = UIColor.white
        progressView.layer.cornerRadius = CGFloat(progressHeight / 2.0)
        progressView.layer.masksToBounds = true
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MCPixelRatio(80))
            make.right.equalToSuperview().offset(-MCPixelRatio(80))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(MCPixelRatio(30))
            make.height.equalTo(progressHeight)
        }
        
        timeLabel.text = MCFormatTimeCount(timeTotal)
        timeLabel.textColor = UIColor.white
        timeLabel.font = MCMarkerFeltWideFont(18)
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(progressView.snp.bottom)
            make.centerX.equalTo(progressView)
        }
        
        rightControl.addTarget(self, action: #selector(rightControlClick(_:)), for: .touchUpInside)
        view.addSubview(rightControl)
        rightControl.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
        }
        
        leftControl.addTarget(self, action: #selector(leftControlClick(_:)), for: .touchUpInside)
        view.addSubview(leftControl)
        leftControl.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
        }
        
        view.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        navigationBar.backButtonCallBack = { ()->(Void) in
            MCManager.share().replaceRootController(MCStartController())
        }
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(MCPixelRatio(44))
        }
    }
    func configureData() {
        resetCurrentWord()
        timeCount = timeTotal
        resetTimerDisplay()
    }
}

// MARK: - Override
extension MCGameController {
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
}
