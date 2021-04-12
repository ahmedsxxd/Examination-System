USE [ExaminationSystem]

CREATE PROC [dbo].[sp_exam_generation]  @cur_Id INT, @no_TF INT, @no_ML INT, @exam_time INT, @exam_gread INT
AS
BEGIN
	INSERT INTO Exam(ExamGrade , ExamTime, CurId)
	VALUES     (@exam_gread, @exam_time,@cur_Id)

DECLARE @ex_id INT
SELECT  @ex_id = MAX(ExamId) FROM Exam

INSERT INTO Exam_Question    --Generate true & false Question
	SELECT TOP(@no_TF) @ex_id, Q.QuesId
	FROM Question Q JOIN course C ON C.CurId =Q.CurId
	WHERE C.CurId = @cur_Id AND Q.QuesType IN('TF')
	ORDER BY NEWID()	

INSERT INTO Exam_Question	--Generate true & false Question
	SELECT TOP(@no_ML) @ex_id, Q.QuesId
	FROM Question Q JOIN course C ON C.CurId =Q.CurId
	WHERE C.CurId = @cur_Id AND Q.QuesType IN('MC')
	ORDER BY NEWID()

SELECT  Q.QuesId, Q.question, A, B, C, D  --Return Exam Question
	FROM Question Q INNER JOIN Choices mcq ON Q.QuesId =mcq.QuesId
	JOIN Exam_Question EX ON Q.QuesId = EX.QuesId
	WHERE EX.ExamId = @ex_id

END
GO


