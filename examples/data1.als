module Data

sig Person {}
sig Course {
  teacher: some Person,
  students: set Person,
  prereqs: set Course,
} {
  // no t: teacher | t in students
  no teacher & students
  // no this & prereqs
}

fact TeacherIsNotStudent {
  all c: Course | no c.teacher & c.students
}

fact NoPrereqCycles {
  no c: Course | c in c.^(prereqs)
}

pred show { }
run show for 3