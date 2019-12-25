//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Shadrach Mensah on 25/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    func test_start_WithNoQuestions_doesNotRouteToAnyQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:[],router:router)
        sut.start()
        XCTAssertEqual(router.questionCount, 0)
    }
    
    func test_start_WithOneQuestions_RouteToQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions: ["01"], router:router)
        sut.start()
        XCTAssertEqual(router.questionCount, 1)
    }
    
    func test_start_WithOneQuestions_RouteToCorrectQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions: ["01"], router:router)
        sut.start()
        XCTAssertEqual(router.questionCount, "01")
    }
    
    class RouterSpy:Router{
        var questionCount:Int = 0
        var routedQuestion:String?
        func routeTo(question: String) {
            questionCount += 1
            routedQuestion = question
        }
    }
}
