//
//  WaveView.swift
//  smile_iOS
//
//  Created by MacBook on 5/18/20.
//  Copyright © 2020 Tomosia. All rights reserved.
//

import UIKit
@IBDesignable
class WaveView: UIView {
    var waveHeight: CGFloat = 10
    var waveSpeed: CGFloat = 1.5

    private var timer: CADisplayLink?
    private var A: CGFloat = 0
    private var v: CGFloat = 0
    private var 𝛌: CGFloat = 0
    private var T: CGFloat = 0
    private var t: CGFloat = 0
    private let pi = CGFloat.pi

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        A = waveHeight
        v = waveSpeed
        𝛌 = frame.width / 1.2
        T = 𝛌 / v
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawWave(rect: rect, in: context)
    }

    private func drawWave(rect: CGRect, in context: CGContext) {
        context.clear(rect)
        let path = UIBezierPath()
        var coordinates: [(CGFloat, CGFloat)] = []
        path.move(to: CGPoint(x: 0, y: rect.height))
        for x in 0 ..< Int(rect.width) {
            let z = 2 * pi * (t / T - CGFloat(x) / 𝛌)
            let y = center.y - A * cos(z)
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
            coordinates.append((CGFloat(x), y))
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        UIColor.cyan.setStroke()
        path.stroke()
        UIColor.cyan.setFill()
        path.fill()
        path.close()
        context.addPath(path.cgPath)
        context.drawPath(using: .fill)
    }

    @objc private func reDraw() {
        t += 1
        setNeedsDisplay()
    }

    func start() {
        timer = CADisplayLink(target: self, selector: #selector(reDraw))
        timer?.add(to: RunLoop.current, forMode: .common)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
