USE [ExaminationSystem]

CREATE PROC [dbo].[sp_exam_Correction] @stud_id int, @exam_id int
AS
DECLARE @total_questions int
SELECT  @total_questions = count(QuesId) FROM Student_Exam
WHERE  StudId = @stud_id AND ExamId = @exam_id

DECLARE @total_right_questions float
SELECT  @total_right_questions = count(SE.QuesId) 
FROM Student_Exam SE JOIN Question Q ON SE.QuesId = Q.QuesId
WHERE  StudId = @stud_id AND ExamId = @exam_id AND SE.StudQuesAns = Q.QuesAnswer

DECLARE @Grade float
SELECT  @Grade = @total_right_questions/@total_questions*100

UPDATE Student_Course
SET	   Grade = @Grade
WHERE  StuId = @stud_id and CurId = (Select CurId from Exam where ExamId = @exam_id)

SELECT 'student degree percentage' + str(@Grade) + '%'



