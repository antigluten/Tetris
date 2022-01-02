//
//  TetrisGameView.swift
//  Tetris
//
//  Created by Vladimir Gusev on 02.01.2022.
//

import SwiftUI

struct TetrisGameView: View {
    @ObservedObject var tetrisGame = TetrisGameViewModel()
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            self.drawBoard(boundingRect: geometry.size)
        }
    }
    
    func drawBoard(boundingRect: CGSize) -> some View {
        let columns = self.tetrisGame.numColumns
        let rows = self.tetrisGame.numRows
        let blockSize = min(boundingRect.width/CGFloat(columns), boundingRect.height/CGFloat(rows))
        
        let xOffset = (boundingRect.width - blockSize * CGFloat(columns)) / 2
        let yOffset = (boundingRect.height - blockSize * CGFloat(rows)) / 2
        
        return ForEach(0...columns - 1, id: \.self) { (column: Int) in
            ForEach(0...rows - 1, id: \.self) { (row: Int) in
                Path { path in
                    // TODO: redesign x and y coordinate systems
                    // I consider yOffset here as useless chank of code, maybe
                    let x = xOffset + blockSize * CGFloat(column)
                    let y = boundingRect.height - blockSize * CGFloat(row + 1)
                    
//                    let x = xOffset + blockSize * CGFloat(column)
//                    let y = boundingRect.height - yOffset - blockSize * CGFloat(row + 1)
                    
                    
                    let rect = CGRect(x: x, y: y, width: blockSize, height: blockSize)
                    path.addRect(rect)
                }
                .fill(self.tetrisGame.gameBoard[column][row].color)
                .border(Color.white)
                .onTapGesture {
                    self.tetrisGame.squareClicked(row: row, column: column)
                }
                
            }
        }
    }
}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
