resource "aws_ecr_repository" "sample" {
  name = "sample"
}

resource "aws_ecr_lifecycle_policy" "sample" {
  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Hold only 10 images, expire all others",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "imageCountMoreThan",
            "countNumber" : 10,
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
    }
  )

  repository = aws_ecr_repository.sample.name
}