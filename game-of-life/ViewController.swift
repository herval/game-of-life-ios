//
//  ViewController.swift
//  Game of Life
//
//  Created by Herval Freire on 3/11/16.
//  Copyright © 2016 Geekery Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var boardView: BoardView!
    
    var board: ReactiveBoard!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let width = 120
        let height = Int((boardView.bounds.width/boardView.bounds.height)*CGFloat(width))
        
        self.board = ReactiveBoard(width: width, height: height, onUpdate: {
            self.boardView.render(self.board.data())
        })

        self.board?.seed()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func seed(sender: AnyObject) {
        board.seed()
    }

    @IBAction func step(sender: AnyObject) {
        board.step()
    }
    
    @IBAction func playPause(sender: AnyObject) {
        board.playPause()
    }

}

