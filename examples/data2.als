module Data

abstract sig CourseItem {}
sig Video, Exercise extends CourseItem {}

sig Course {
  prereqs: set Course,
  items: set CourseItem
}
fact NoPrereqCycles {
  no c: Course | c in c.^(prereqs)
}

sig Person {}
sig CourseInstance {
  course: Course,
  teachers: some Person,
  students: some Person,
  grades: students -> CourseItem -> lone Int
} {
  no teachers & students
  all s: students | grades[s].univ in (course.items & Exercise)
}

pred show { 
  all c: CourseInstance
    | #c.students > 1 and #c.grades > 2
}
run show for 5