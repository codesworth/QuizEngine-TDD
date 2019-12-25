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
        XCTAssert(router.routedQuestions.isEmpty)
    }
    

    
    func test_start_WithOneQuestions_RouteToCorrectQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions: ["01"], router:router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["01"])
    }
    
    func test_start_WithOneQuestions_RouteToCorrectQuestion_2(){
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router:router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    func test_start_WithTwoQuestions_RouteToFirstQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router:router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_WithTwoQuestions_RouteToFirstQuestionTwice(){
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router:router)
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_start_AndAnswerFirstQuestion_WithTwoQuestions_RouteToSecondQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router:router)
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2"])
    }
    
    class RouterSpy:Router{
        var answerCallback:((String)-> Void) = {_ in}
        var routedQuestions:[String] = []
        func routeTo(question: String, answerCallback:@escaping (String)-> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
