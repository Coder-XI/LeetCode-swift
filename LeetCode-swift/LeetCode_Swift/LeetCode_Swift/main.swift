//
//  main.swift
//  LeetCode_Swift
//
//  Created by T-Mac on 2/8/17.
//  Copyright © 2017 T-Mac. All rights reserved.
//

import Foundation


/*****************q sort*********************/
func qqsort(array: inout Array<Int>, start: Int, end: Int) -> Void {
    if start >= end {
        return;
    }
    let guarder:Int = array[start];
    var s = start;
    var e = end;
    
    while s < e {
        while s < e && guarder <= array[e] {
            e -= 1
        }
        array[s] = array[e]
        
        while s < e && guarder >= array[s] {
            s += 1
        }
        array[e] = array[s]
    }
    array[s] = guarder;
    
    qqsort(array: &array, start: start, end: s - 1)
    qqsort(array: &array, start: s + 1, end: end)
}

func combinationSum2Helper(candidates: [Int], index:Int, _ target: Int, condition:inout [Int], result:inout [[Int]]) -> Void {
    if target < candidates[index] {
        return;
    }else if target == candidates[index] {
        condition.append(candidates[index])
        result.append(Array(condition))
        condition.removeLast()
        return;
    }else {
        condition.append(candidates[index]);
        for i in index + 1 ..< candidates.count {
            if i > index+1 && candidates[i]==candidates[i-1] {
                continue;
            }
            if target - candidates[index] >= candidates[i] {
                 combinationSum2Helper(candidates: candidates, index: i,target - candidates[index],condition:&condition, result: &result);
            }
        }
        condition.removeLast()
    }
}
/*****************combinationSum2*********************/
func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var array = Array(candidates);
    qqsort(array: &array, start: 0, end: array.count - 1)
    var res:[[Int]] = Array();
    var arrTemp:[Int] = Array()
    for i:Int in 0 ..< array.count {
        if i>0 && array[i] == array[i-1] {
            continue;
        }
        combinationSum2Helper(candidates: array, index: i,target, condition:&arrTemp , result: &res);
    }
    return res;
}



class Solution {
    func convertToBase7(_ num: Int) -> String {
        var number = abs(num)
        var res : String = String()
        while number >= 7 {
            res = "\(number % 7)" + res
            number = number / 7;
        }
        res = "\(number)" + res
        if num >= 0 {
            return res
        }else {
            return "-" + res
        }
        
    }
    func findDisappearedNumbers(_ nums:[Int]) -> [Int] {
        var numbers = Array(nums)
        for i in 0..<numbers.count {
            let m = abs(numbers[i]) - 1
            numbers[m] = numbers[m] > 0 ? -numbers[m] : numbers[m]
        }
        var res:[Int] = Array()
        for i in 0..<numbers.count {
            if numbers[i] > 0 {
                res.append(i + 1)
            }
        }
        return res
    }
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var res:Int = 0, max:Int = 0
        for i in 0..<nums.count {
            if nums[i] == 1 {
                res += 1
            } else {
                if res > max {
                    max = res
                }
                res = 0
            }
        }

        return max > res ? max : res
    }
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var num:Int = x ^ y
        var count:Int = 0
        while num > 0 {
            count = 1 + count
            num = num & (num - 1)
        }
        return count
    }
    func findWords(_ words: [String]) -> [String] {
        let vertifySource = ["qwertyuiop","asdfghjkl","zxcvbnm"]
        var res:[String] = Array()
        for str in vertifySource {
            for desStr in words {
                if Set(str.characters).isSuperset(of: Set(desStr.lowercased().characters)) {
                    res.append(desStr)
                }
            }
        }
        return res
    }
    
    func findComplement(_ num: Int) -> Int {
        var str:String = String()
        for ch in String(num, radix:2).characters {
            if ch == "1" {
                str.append("0")
            } else {
                str.append("1")
            }
        }
        return Int(str, radix: 2)!
    }
    func nextGreaterElement(_ findNums: [Int], _ nums: [Int]) -> [Int] {
        var res:[Int] = Array()
        for number in findNums {
            let index = nums.index(of: number)
            if index == nums.count - 1 {
                res.append(-1)
            } else {
                let newIndex:[Int] = Array(nums[index!..<nums.count])
                let flag = res.count
                for i in newIndex {
                    if i > number {
                        res.append(i)
                        break
                    }
                }
                if flag == res.count {
                    res.append(-1)
                }
            }
        }
        return res
    }
}

func test() -> Void {
    print(Solution().nextGreaterElement([4,1,2], [1,3,4,2]))
}
test();

print("Hello, World!")

