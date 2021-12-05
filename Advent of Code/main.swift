//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    var points: [String: Int] = [:]

    lines.forEach { line in
        let lineArr = line.components(separatedBy: " -> ")
        let from = lineArr[0].components(separatedBy: ",").map { Int($0)! }
        let to = lineArr[1].components(separatedBy: ",").map { Int($0)! }

        let fromX = min(from[0], to[0])
        let fromY = min(from[1], to[1])
        let toX = max(from[0], to[0])
        let toY = max(from[1], to[1])

        if fromX != toX && fromY != toY { return }
//        print("non-diagonal line: \(line)")
        for i in fromX ... toX {
            for j in fromY ... toY {
                let pt = points["\(i),\(j)"] ?? 0
                points["\(i),\(j)"] = pt + 1
//                print("\(i),\(j)")
            }
        }
    }

    let result = points.reduce(0) { partialResult, element in
        partialResult + (element.value > 1 ? 1 : 0)
    }

    print(result)
//    printPoints(points)
}

func main2() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }

    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    var points: [String: Int] = [:]

    lines.forEach { line in
        let lineArr = line.components(separatedBy: " -> ")
        let from = lineArr[0].components(separatedBy: ",").map { Int($0)! }
        let to = lineArr[1].components(separatedBy: ",").map { Int($0)! }

        let fromX = min(from[0], to[0])
        let fromY = min(from[1], to[1])
        let toX = max(from[0], to[0])
        let toY = max(from[1], to[1])

        if fromX - toX == fromY - toY {
//            print("diagonal line: \(line)")
            var i = from[0]
            var j = from[1]
            let incX = from[0] < to[0] ? 1 : -1
            let incY = from[1] < to[1] ? 1 : -1
            repeat {
                let pt = points["\(i),\(j)"] ?? 0
                points["\(i),\(j)"] = pt + 1
//                print("\(i),\(j)")
                i += incX
                j += incY
            } while i - incX != to[0]
        } else if fromX == toX || fromY == toY {
//            print("non-diagonal line: \(line)")
            for i in fromX ... toX {
                for j in fromY ... toY {
                    let pt = points["\(i),\(j)"] ?? 0
                    points["\(i),\(j)"] = pt + 1
//                    print("\(i),\(j)")
                }
            }
        }
    }

    let result = points.reduce(0) { partialResult, element in
        partialResult + (element.value > 1 ? 1 : 0)
    }

//    print(points)
    print(result)

//    printPoints(points)
}

func printPoints(_ points: [String: Int]) {
    for j in 0...9 {
        var line = [String]()
        for i in 0...9 {
            if let c = points["\(i),\(j)"] {
                line.append("\(c)")
            } else {
                line.append(".")
            }
        }
        print(line.joined(separator: ""))
    }
}

//main()
main2()
