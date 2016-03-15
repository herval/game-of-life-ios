//
//  ReactiveBoard.swift
//  game-of-life
//
//  Created by Herval Freire on 3/14/16.
//  Copyright © 2016 Geekery Corp. All rights reserved.
//

import Foundation
import RxSwift

class ReactiveBoard {
    private let board: Board!;
    private let backgroundThread: SerialDispatchQueueScheduler!
    private let clock: Observable<Int>!
    private let callback: () -> ()!
    private var run: Bool = false
    private var subscription: Disposable?

    init(width: Int, height: Int, onUpdate: () -> ()) {
        self.board = Board(width: width, height: height);

        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        self.backgroundThread = SerialDispatchQueueScheduler(queue: queue, internalSerialQueueName: "life")
        self.clock = Observable<Int>.interval(0.1, scheduler: backgroundThread).observeOn(backgroundThread)
        self.callback = onUpdate
        
        self.subscription = self.clock.filter(clockTick).map { _ in
            self.board.step()
        }.observeOn(MainScheduler.instance).subscribe { (event) -> Void in
            onUpdate()
        }
    }
    
    func data() -> Array<Array<Bool>> {
        return self.board.board
    }
    
    func seed() {
        board.seed()
        callback()
    }
    
    func step() {
        board.step()
        callback()
    }
    
    func playPause() {
        run = !run
    }
    
    func kill() {
        self.subscription?.dispose()
    }
    
    func printBoard() -> String {
        return board.printBoard()
    }
    
    func clockTick(t: Int) -> Bool {
        return run
    }
    
}
