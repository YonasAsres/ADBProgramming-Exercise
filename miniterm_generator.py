class MinitermGenerator:
    def __init__(self, predicates):
        self.predicates = predicates

    def generate_horizontal_miniterms(self):
        miniterms = []
        for predicate in self.predicates:
            miniterms.append((predicate,))
        return miniterms

# Test the class
employee_predicates = ["Employee.name", "Employee.department", "Employee.salary"]
miniterm_gen = MinitermGenerator(employee_predicates)
horizontal_miniterms = miniterm_gen.generate_horizontal_miniterms()
print(horizontal_miniterms)