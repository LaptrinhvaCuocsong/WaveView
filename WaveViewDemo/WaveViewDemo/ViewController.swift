//
//  ViewController.swift
//  WaveViewDemo
//
//  Created by Apple on 7/5/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var animationView: UIView!

    private var waveView: WaveView!

    override func viewDidLoad() {
        super.viewDidLoad()

        waveView = WaveView(frame: animationView.bounds)
        animationView.addSubview(waveView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        waveView.start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        waveView.stop()
    }
}
