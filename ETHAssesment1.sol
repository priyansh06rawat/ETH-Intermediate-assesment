// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract SchoolGradingSystem {
    address public admin;
    mapping (string => uint) public studentGrades;
    constructor() {
        admin = msg.sender;
    }
    function setGrade(string memory studentId, uint grade) public {
        require(msg.sender == admin, "Only the admin can set grades.");
        require(grade >= 0 && grade <= 100, "Grade must be between 0 and 100.");
        studentGrades[studentId] = grade;
    }
    function getGrade(string memory studentId) public view returns (uint) {
        if(studentGrades[studentId] == 0) {
            revert("Student not found.");
        }
        return studentGrades[studentId];
    }
    function updateAdmin(address newAdmin) public {
        assert(admin!= address(0));
        admin = newAdmin;
    }
    function deleteStudent(string memory studentId) public {
        require(msg.sender == admin, "Only the admin can delete students.");
        delete studentGrades[studentId];
    }
}
