#!/usr/bin/env python
import itertools

SPECIAL_PREDICATES = ["increase" ,"decrease", "forall", "minimize", "maximize"]

class PlanAction:
    def __init__(self, name, objects):
        self.name = name;
        self.objects = objects;

class Action:

    #-----------------------------------------------
    # Initialize
    #-----------------------------------------------

    def __init__(self, name, parameters, positive_preconditions, negative_preconditions, add_effects, del_effects, extensions = None):
        def frozenset_of_tuples(data):
            _data = []
            for t in data:
                _t = []
                if t[0] in SPECIAL_PREDICATES:
                    _t = ground_array(list(), t)
                else:
                    _t = t
                _data += [_t]
            return frozenset([tuple(t) for t in _data])
        self.name = name
        self.parameters = parameters
        self.positive_preconditions = frozenset_of_tuples(positive_preconditions)
        self.negative_preconditions = frozenset_of_tuples(negative_preconditions)
        self.add_effects = frozenset_of_tuples(add_effects)
        self.del_effects = frozenset_of_tuples(del_effects)

    #-----------------------------------------------
    # to String
    #-----------------------------------------------

    def __str__(self):
        return 'action: ' + self.name + \
        '\n  parameters: ' + str(self.parameters) + \
        '\n  positive_preconditions: ' + str([list(i) for i in self.positive_preconditions]) + \
        '\n  negative_preconditions: ' + str([list(i) for i in self.negative_preconditions]) + \
        '\n  add_effects: ' + str([list(i) for i in self.add_effects]) + \
        '\n  del_effects: ' + str([list(i) for i in self.del_effects]) + '\n'

    #-----------------------------------------------
    # Equality
    #-----------------------------------------------

    def __eq__(self, other): 
        return self.__dict__ == other.__dict__

    #-----------------------------------------------
    # Groundify
    #-----------------------------------------------

    def groundify(self, objects, types):
        if not self.parameters:
            yield self
            return
        type_map = []
        variables = []
        for var, type in self.parameters:
            type_stack = [type]
            items = []
            while type_stack:
                t = type_stack.pop()
                if t in objects:
                    items += objects[t]
                elif t in types:
                    type_stack += types[t]
                else:
                    raise Exception('Unrecognized type ' + t)
            type_map.append(items)
            variables.append(var)
        for assignment in itertools.product(*type_map):
            positive_preconditions = self.replace(self.positive_preconditions, variables, assignment)
            negative_preconditions = self.replace(self.negative_preconditions, variables, assignment)
            add_effects = self.replace(self.add_effects, variables, assignment)
            del_effects = self.replace(self.del_effects, variables, assignment)
            yield Action(self.name, assignment, positive_preconditions, negative_preconditions, add_effects, del_effects)

    #-----------------------------------------------
    # Replace
    #-----------------------------------------------

    def replace(self, group, variables, assignment):
        g = []
        for pred in group:
            pred = list(pred)
            iv = 0
            for v in variables:
                while v in pred:
                    pred[pred.index(v)] = assignment[iv]
                iv += 1
            g.append(pred)
        return g
    
#-----------------------------------------------
# Ground array
#-----------------------------------------------
def ground_array(arr, array):
    if arr and not array[0] in SPECIAL_PREDICATES:
        arr.append("(")

    for elem in array:
        if not isinstance(elem, list):
            arr.append(elem)
        else:
            ground_array(arr, elem)

    if arr and not array[0] in SPECIAL_PREDICATES:
        arr.append(")")

    return arr