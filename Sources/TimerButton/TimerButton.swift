import UIKit

class TimerButton: UIButton {
    
    // MARK: - Private properties
    
    private var gradient: CAGradientLayer!
    private var countdownTimer: Timer!
    private var totalTime: TimeInterval = 60 //60
    private var duration: TimeInterval = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createGradientLayer()
        startup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createGradientLayer()
        startup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
        gradient.cornerRadius = bounds.height/2
        gradient.frame = bounds
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isEnabled { startup() }
    }
    
    private func startup() {
        isEnabled = false
        totalTime = 60
        startTimer()
        startAnimation()
    }
    
    private func createGradientLayer() {
//        let startColor = UIColor(hex: "FF2300").withAlphaComponent(0.2).cgColor
//        let endColor = UIColor(hex: "FF2300").withAlphaComponent(0.1).cgColor
        let startColor = UIColor.red.withAlphaComponent(0.2)
        let endColor = UIColor.red.withAlphaComponent(0.1)
        gradient = CAGradientLayer(layer: layer)
        gradient.colors = [startColor, endColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0, 0]
        animation.toValue = [1, 1]
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        gradient.add(animation, forKey: "anim_locations")
    }
    
    func startTimer() {
        print("#Timer: started")
        NSLog("#Timer:", "Started")
        countdownTimer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(updateTime(_:)),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    @objc func updateTime(_ timer: Timer) {
        //        timerLabel.text = "\(timeFormatted(totalTime))"
        
        NSLog("#Timer:", "\(timeFormatted(Int(totalTime)))")
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            isEnabled = true
            timer.invalidate()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
