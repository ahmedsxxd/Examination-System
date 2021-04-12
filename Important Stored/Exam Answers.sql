USE [ExaminationSystem]

CREATE PROC [dbo].[sp_stud_Answer] @stud_id int, @exam_id int, @question_id int, @stud_answer varchar(30)
AS
	IF not EXISTS (SELECT * FROM Student_Exam WHERE StudId = @stud_id AND ExamId = @exam_id)
			INSERT INTO Student_Exam(StudId, ExamId, QuesId, StudQuesAns)
		    VALUES(@stud_id, @exam_id, @question_id, @stud_answer )



