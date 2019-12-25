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
    
    let router = RouterSpy()
    
    
    
    func test_start_WithNoQuestions_doesNotRouteToAnyQuestion(){
        makeSUT(questions: []).start()
        XCTAssert(router.routedQuestions.isEmpty)
    }
    

    
    func test_start_WithOneQuestions_RouteToCorrectQuestion(){
        
        
        makeSUT(questions: ["01"]).start()
        XCTAssertEqual(router.routedQuestions, ["01"])
    }
    
    func test_start_WithOneQuestions_RouteToCorrectQuestion_2(){
        
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    func test_start_WithTwoQuestions_RouteToFirstQuestion(){
        
        makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_WithTwoQuestions_RouteToFirstQuestionTwice(){
        
        let sut = makeSUT(questions:["Q1", "Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    
    
    func test_start_AndAnswerFirstQuestion_WithOneQuestions_DoesNotRouteToSecondQuestion(){
        
        let sut = makeSUT(questions:["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_AndAnswerFirstAndSecondQuestion_WithThreeQuestions_RouteTohirdQuestion(){
        
        let sut = makeSUT(questions:["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_start_WithNoQuestions_RoutesToResults(){
        makeSUT(questions: []).start()
        XCTAssertEqual(router.routedResult, [:])
    }
    
    func test_start_AndAnswerFirstQuestion_WithOneQuestions_routesToResult(){
        
        let sut = makeSUT(questions:["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResult, ["Q1":"A1"])
    }
    
    func test_start_AndAnswerTwoQuestionsWithTwoQuestions_RouteToResult(){
        
        let sut = makeSUT(questions:["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult, ["Q1":"A1","Q2":"A2"])
    }
    
    func test_start_AndAnswerOneQuestionsWithTwoQuestions_doesNotRouteToResult(){
        
        let sut = makeSUT(questions:["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
    }
    
    //MARK:- HELPERS
    
    func makeSUT(questions:[String])->Flow{
        return Flow(questions:  questions,router:router)
    }
    
    class RouterSpy:Router{
        var answerCallback:((String)-> Void) = {_ in}
        var routedQuestions:[String] = []
        var routedResult:[String:String]?
        func routeTo(question: String, answerCallback:@escaping (String)-> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        func routeTo(result: [String : String]) {
             routedResult = result
        }
    }
}
