class ExamModel
{
   late String question;
   late int questionType;
   late List<String>  options;
   late bool isAtempted;
   late bool isReview;

   ExamModel(String question,int questionType,List<String>  options,
       bool isAtempted,bool isReview)
   {
     this.question=question;
     this.questionType=questionType;
     this.options=options;
     this.isAtempted=isAtempted;
     this.isReview=isReview;
   }
}