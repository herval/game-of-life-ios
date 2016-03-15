//
//  BoardView.swift
//  game-of-life
//
//  Created by Herval Freire on 3/14/16.
//  Copyright © 2016 Geekery Corp. All rights reserved.
//

import UIKit

class BoardView: UIView {
    private var data: Array<Array<Bool>>?
    private var squareSize: CGFloat = 0.0
    
    func render(board: Array<Array<Bool>>) {
        self.data = board
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        guard let data = self.data,
              let context = UIGraphicsGetCurrentContext()
        else {
            return
        }
        
        squareSize = rect.width/CGFloat(data.count)
        

        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        
        data.indices.forEach({ row in
            data[row].indices.forEach({ col in
                if(data[row][col]) {
                    renderDot(context, row: CGFloat(row), col: CGFloat(col))
                }
            })
        })
    }
    
    private func renderDot(context: CGContextRef, row: CGFloat, col: CGFloat) {
        
        CGContextFillRect(context, CGRectMake(
            squareSize*row,
            squareSize*col,
            squareSize,
            squareSize
        ))
    }

}
