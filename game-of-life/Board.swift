//
//  Board.swift
//  game-of-life
//
//  Created by Herval Freire on 3/11/16.
//  Copyright © 2016 Geekery Corp. All rights reserved.
//

import Foundation

public class Board {
    var board: Array<Array<Bool>>
    let width: Int
    let height: Int
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.board = Board.blankSlate(width, height: height)
    }
    
    private static func blankSlate(width: Int, height: Int) -> Array<Array<Bool>> {
        return Array(count: height, repeatedValue: Array(count: width, repeatedValue: false))
    }
    
    func seed() {
        for x in Range(0..<height) {
            for y in Range(0..<width) {
                board[x][y] = (rand() % 3 == 0)
            }
        }
    }
    
    func bringToLife(x x: Int, y: Int) {
        board[x][y] = true
    }
    
    func liveOrDie(posX posX: Int, posY: Int) -> Bool {
        var q = 0
        let alive = board[posX][posY]
        let xRange = Range(max(0, posX-1)..<min(height, posX+2))
        let yRange = Range(max(0, posY-1)..<min(width, posY+2))
        for x in xRange {
            for y in yRange {
                if(!(x == posX && y == posY) && board[x][y]) {
                    q+=1
                }
                // Any live cell with more than three live neighbours dies, as if by over-population
                if(alive && q > 3) {
                    return false
                }
            }
        }
        
        // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        // Any live cell with fewer than two live neighbours dies, as if caused by under-population.
        // Any live cell with two or three live neighbours lives on to the next generation.
        return (alive && q == 2 || q == 3) || (!alive && q == 3)
    }
    
    // advances one generation
    func step() {
        var newUniverse = Board.blankSlate(width, height: height)
        
        for x in newUniverse.indices {
            for y in newUniverse[x].indices {
                newUniverse[x][y] = liveOrDie(posX: x, posY: y)
            }
        }
        
        board = newUniverse
    }
    
    func printBoard() -> String {
        return self.board.map { (row) -> String in
            row.map { (b) -> String in
                if(b) { return "*" } else { return " " }
                }.joinWithSeparator("")
            }.joinWithSeparator("\n")
    }
    
}