#!/usr/bin/env python
# Four spaces as indentation [no tabs]

import re
from pddl_parser.action import Action
from pddl_parser.action import PlanAction
from textwrap import indent
from pddl_parser.n2w import N2W
import logging
import os, sys

class PDDL_Parser:

    SUPPORTED_REQUIREMENTS = [':strips', ':negative-preconditions', ':typing', ':equality', ':adl', ':action-costs']

    #-----------------------------------------------
    # Tokens
    #-----------------------------------------------

    def scan_tokens(self, filename):
        with open(filename,'r') as f:
            # Remove single line comments
            str = re.sub(r';.*$', '', f.read(), flags=re.MULTILINE).lower()
        # Tokenize
        stack = []
        list = []
        for t in re.findall(r'[()]|[^\s()]+', str):
            if t == '(':
                stack.append(list)
                list = []
            elif t == ')':
                if stack:
                    l = list
                    list = stack.pop()
                    list.append(l)
                else:
                    raise Exception('Missing open parentheses')
            else:
                list.append(t)
        if stack:
            raise Exception('Missing close parentheses')
        if len(list) != 1:
            raise Exception('Malformed expression')
        return list[0]

    #-----------------------------------------------
    # Parse domain
    #-----------------------------------------------

    def parse_domain(self, domain_filename):
        tokens = self.scan_tokens(domain_filename)
        if type(tokens) is list and tokens.pop(0) == 'define':
            self.domain_name = 'unknown'
            self.requirements = []
            self.types = {}
            self.objects = {}
            self.actions = []
            self.predicates = {}
            self.functions = {}
            while tokens:
                group = tokens.pop(0)
                t = group.pop(0)
                if t == 'domain':
                    self.domain_name = group[0]
                elif t == ':requirements':
                    for req in group:
                        if not req in self.SUPPORTED_REQUIREMENTS:
                            raise Exception('Requirement ' + req + ' not supported')
                    self.requirements = group
                elif t == ':constants':
                    self.parse_objects(group, t)
                elif t == ':predicates':
                    self.parse_predicates(group)
                elif t == ':functions':
                    self.parse_functions(group)
                elif t == ':types':
                    self.parse_types(group)
                elif t == ':action':
                    self.parse_action(group)
                else: self.parse_domain_extended(t, group)
        else:
            raise Exception('File ' + domain_filename + ' does not match domain pattern')

    def parse_domain_extended(self, t, group):
        print(str(t) + ' is not recognized in domain')

    def get_domain_name(self, domain_filename):
        self.parse_domain(domain_filename)
        return self.domain_name

    #-----------------------------------------------
    # Parse hierarchy
    #-----------------------------------------------

    def parse_hierarchy(self, group, structure, name, redefine):
        list = []
        while group:
            if redefine and group[0] in structure:
                raise Exception('Redefined supertype of ' + group[0])
            elif group[0] == '-':
                if not list:
                    raise Exception('Unexpected hyphen in ' + name)
                group.pop(0)
                type = group.pop(0)
                if not type in structure:
                    structure[type] = []
                structure[type] += list
                list = []
            else:
                list.append(group.pop(0))
        if list:
            if not 'object' in structure:
                structure['object'] = []
            structure['object'] += list

    #-----------------------------------------------
    # Parse objects
    #-----------------------------------------------

    def parse_objects(self, group, name):
        self.parse_hierarchy(group, self.objects, name, False)

    # -----------------------------------------------
    # Parse types
    # -----------------------------------------------

    def parse_types(self, group):
        self.parse_hierarchy(group, self.types, 'types', True)

    #-----------------------------------------------
    # Parse predicates
    #-----------------------------------------------

    def parse_predicates(self, group):
        for pred in group:
            predicate_name = pred.pop(0)
            if predicate_name in self.predicates:
                raise Exception('Predicate ' + predicate_name + ' redefined')
            arguments = {}
            untyped_variables = []
            while pred:
                t = pred.pop(0)
                if t == '-':
                    if not untyped_variables:
                        raise Exception('Unexpected hyphen in predicates')
                    type = pred.pop(0)
                    while untyped_variables:
                        arguments[untyped_variables.pop(0)] = type
                else:
                    untyped_variables.append(t)
            while untyped_variables:
                arguments[untyped_variables.pop(0)] = 'object'
            self.predicates[predicate_name] = arguments

    #-----------------------------------------------
    # Parse function
    #-----------------------------------------------

    def parse_functions(self, group):

        for func in group:
            if func == '-' or func == 'number':
                continue
            
            function_name = func.pop(0)
            if function_name in self.predicates:
                raise Exception('Function ' + function_name + ' redefined')
            arguments = {}
            untyped_variables = []
        
            while func:
                t = func.pop(0)
                if t == '-':
                    if not untyped_variables:
                        raise Exception('Unexpected hyphen in predicates')
                    type = func.pop(0)
                    while untyped_variables:
                        arguments[untyped_variables.pop(0)] = type
                else:
                    untyped_variables.append(t)
            while untyped_variables:
                arguments[untyped_variables.pop(0)] = 'object'
            self.functions[function_name] = arguments

    #-----------------------------------------------
    # Parse action
    #-----------------------------------------------

    def parse_action(self, group):
        name = group.pop(0)
        if not type(name) is str:
            raise Exception('Action without name definition')
        for act in self.actions:
            if act.name == name:
                raise Exception('Action ' + name + ' redefined')
        parameters = []
        positive_preconditions = []
        negative_preconditions = []
        add_effects = []
        del_effects = []
        extensions = None
        while group:
            t = group.pop(0)
            if t == ':parameters':
                if not type(group) is list:
                    raise Exception('Error with ' + name + ' parameters')
                parameters = []
                untyped_parameters = []
                p = group.pop(0)
                while p:
                    t = p.pop(0)
                    if t == '-':
                        if not untyped_parameters:
                            raise Exception('Unexpected hyphen in ' + name + ' parameters')
                        ptype = p.pop(0)
                        while untyped_parameters:
                            parameters.append([untyped_parameters.pop(0), ptype])
                    else:
                        untyped_parameters.append(t)
                while untyped_parameters:
                    parameters.append([untyped_parameters.pop(0), 'object'])
            elif t == ':precondition':
                self.split_predicates(group.pop(0), positive_preconditions, negative_preconditions, name, ' preconditions')
            elif t == ':effect':
                self.split_predicates(group.pop(0), add_effects, del_effects, name, ' effects')
            else: extensions = self.parse_action_extended(t, group)
        self.actions.append(Action(name, parameters, positive_preconditions, negative_preconditions, add_effects, del_effects, extensions))

    def parse_action_extended(self, t, group):
        print(str(t) + ' is not recognized in action')

    #-----------------------------------------------
    # Parse problem
    #-----------------------------------------------

    def parse_problem(self, problem_filename):
        def frozenset_of_tuples(data):
            tuples = []
            for t in data:
                if t[0] == '=':
                    t = [t[0]] + t[1] + [t[2]] # Example: ['=' , ['total-cost'], 0] into ['=' , 'total-cost', 0]
                tuples += [tuple(t)]            
            return frozenset(tuples)
        tokens = self.scan_tokens(problem_filename)
        if type(tokens) is list and tokens.pop(0) == 'define':
            self.problem_name = 'unknown'
            self.state = frozenset()
            self.positive_goals = frozenset()
            self.negative_goals = frozenset()
            self.metric = []
            while tokens:
                group = tokens.pop(0)
                t = group.pop(0)
                if t == 'problem':
                    self.problem_name = group[0]
                elif t == ':domain':
                    if self.domain_name != group[0]:
                        raise Exception('Different domain specified in problem file')
                elif t == ':requirements':
                    pass # Ignore requirements in problem, parse them in the domain
                elif t == ':objects':
                    self.parse_objects(group, t)
                elif t == ':init':
                    self.state = frozenset_of_tuples(group)
                elif t == ':goal':
                    positive_goals = []
                    negative_goals = []
                    self.split_predicates(group[0], positive_goals, negative_goals, '', 'goals')
                    self.positive_goals = frozenset_of_tuples(positive_goals)
                    self.negative_goals = frozenset_of_tuples(negative_goals)
                elif t == ':metric':
                    if len(group) < 2:
                        raise Exception("Invalid metric in problem file")
                    self.metric = group
                else: self.parse_problem_extended(t, group)
        else:
            raise Exception('File ' + problem_filename + ' does not match problem pattern')

    def parse_problem_extended(self, t, group):
        print(str(t) + ' is not recognized in problem')

    def get_problem_name(self, problem_filename):
        self.parse_problem(problem_filename)
        return self.problem_name

    #-----------------------------------------------
    # Split predicates
    #-----------------------------------------------

    def split_predicates(self, group, positive, negative, name, part):
        if not type(group) is list:
            raise Exception('Error with ' + name + part)
        if group[0] == 'and':
            group.pop(0)
        else:
            group = [group]
        for predicate in group:
            if predicate[0] == 'not':
                if len(predicate) != 2:
                    raise Exception('Unexpected element in ' + name + part)
                negative.append(predicate[-1])
            else:
                positive.append(predicate)

    #-----------------------------------------------
    # Parse plan
    #-----------------------------------------------

    def parse_plan(self, plan):
        plan_actions = []
        actions = []

        with open(plan, encoding="utf-8") as file:
            plan_actions = file.readlines()
            plan_actions = [plan_action.rstrip() for plan_action in plan_actions]

        for plan_action in plan_actions:
            plan_action = plan_action.replace('(','').replace(')','').split()
            name = plan_action[0]
            parameters = []
            if len(plan_action) > 1:
                for param in plan_action[1:]:
                    parameters.append(param)
            actions.append(PlanAction(name, parameters))

        return actions


#-----------------------------------------------
# Domain name
#-----------------------------------------------
def parse_domain_name(name):
    # domain name statement
    return f'(domain {name})'

#-----------------------------------------------
# Requirements
#-----------------------------------------------
def parse_requirements(requirements):
    # requirements statement
    reqs = ''
    if requirements:
        reqs = '(:requirements' 
        for req in requirements:
            reqs += f' {req}'
        reqs += ')'

    return reqs

#-----------------------------------------------
# Types
#-----------------------------------------------
def parse_types(types):

    if (len(types)) < 1:
        return '(:types order)'

    obj_types = ''
    
    for type_key, type_values in types.items():
        for value in type_values:
            obj_types += f'{value} '
        if type_key == 'object':
            obj_types += f'order '
        obj_types += f'- {type_key}\n'
    
    # checking if there is no explicit 'object' type to add order
    if 'object' not in types:
        obj_types += f'order - object\n'

    obj_types = '(:types\n' + indent(obj_types, '\t', lambda line: True) + ')'

    return obj_types

#-----------------------------------------------
# Predicates
#-----------------------------------------------
def parse_action_predicates(actions):
    acts = ''
    for action in actions:
        acts += f'(plan-action-{action.name} ?o - order'
        for param in action.parameters:
            acts += f' {param[0]} - {param[1]}'
        acts += ')\n'
    
    return acts

def parse_predicates(predicates, actions):
    
    preds = ''
    for key, values in predicates.items():
        preds += f'({key}'
        for k, val in values.items():
            preds += f' {k} - {val}'
        preds += ')\n'


    preds += '\n(last ?o - order)\n'
    preds += '(before ?o1 ?o2 - order)\n'
    
    preds = '(:predicates\n' + indent(preds, '\t', lambda line: True) + '\n' + indent(parse_action_predicates(actions), '\t', lambda line: True) + ')'
    return preds

#-----------------------------------------------
# Functions
#-----------------------------------------------
def parse_functions(functions):
    functs = ''
    for key, values in functions.items():
        functs += f'({key}'
        for k, val in values.items():
            functs += f' {k} - {val}'
        functs += ') - number\n'
    
    functs = '(:functions\n' + indent(functs, '\t', lambda line: True) + ')'
    return functs

#-----------------------------------------------
# Actions
#-----------------------------------------------
def create_predicates(predicates, negative=False):
    preds = ''
    for predicate in predicates:
        if not predicate:
            break
        preds += '\n'
        if negative:
            preds += ' (not'
        preds += f' ({predicate[0]}'
        if (len(predicate)) > 1:
            for elem in predicate[1:]:
                preds += f' {elem}'
        preds += ')'
        if negative:
            preds += ')'

    return indent(preds, '\t\t\t', lambda line: True)

def parse_actions(actions):
    acts = ''
    for action in actions:
        acts += f'(:action {action.name}\n'

        # parameters
        acts += f'\t:parameters (?olast - order ?ocurrent - order'
        for param in action.parameters:
            acts += f' {param[0]} - {param[1]}'
        acts += ')\n'

        # preconditions
        acts += f'\t:precondition (and'
        acts += create_predicates(action.positive_preconditions)
        acts += create_predicates(action.negative_preconditions, True)
        acts += '\n\t\t\t (last ?olast)'
        acts += '\n\t\t\t (before ?olast ?ocurrent)'
        acts += f'\n\t\t\t (plan-action-{action.name} ?ocurrent'
        for param in action.parameters:
            acts += f' {param[0]}'
        acts += '))\n'

        # effects
        acts += f'\t:effect (and'
        acts += create_predicates(action.add_effects)
        acts += create_predicates(action.del_effects, True)
        acts += '\n\t\t\t (not (last ?olast))'
        acts += '\n\t\t\t (last ?ocurrent)'
        acts += ')\n'

        acts += ')\n'  
    
    return acts

#-----------------------------------------------
# Problem name
#-----------------------------------------------
def parse_problem_name(name):
    # problem name statement
    return f'(problem {name})'

#-----------------------------------------------
# Problem domain
#-----------------------------------------------
def parse_problem_domain(name):
    # problem name statement
    return f'(:domain {name})'

#-----------------------------------------------
# Objects
#-----------------------------------------------
def parse_objects(objects, plan):
    objs = ''
    for obj_type, _objs in objects.items():
        for obj in _objs:
            objs += f'{obj} '
        objs += f'- {obj_type}\n'

    for i in range(len(plan)+1):
        objs += f'{N2W[i]} '
    objs += '- order'

    objs = '(:objects\n' + indent(objs, '\t', lambda line: True) + ')'
    return objs

#-----------------------------------------------
# Init
#-----------------------------------------------
def parse_init(initial_state, plan):
    init_state = ''
    for predicate in initial_state:
        init_state += f'({predicate[0]}'
        if (len(predicate) > 1):
            if (predicate[0] == '='):
                init_state += f' ('
                for obj in predicate[1:-1]:
                    init_state += f' {obj}'
                init_state += f') {predicate[-1]}'
            else:
                for obj in predicate[1:]:
                    init_state += f' {obj}'
        init_state += ')\n'

    init_state += '\n;; numbers'
    for i in range(len(plan)+1):
        for j in range(i+1, len(plan)+1):
            init_state += f'\n(before {N2W[i]} {N2W[j]})'
    init_state += '\n(last zero)\n'

    init_state += '\n;; found plan\n'
    for i, action in enumerate(plan, 1):
        if action.name != ';':
            init_state += f'(plan-action-{action.name} {N2W[i]}'
            for obj in action.objects:
                init_state += f' {obj}'
            init_state += ')\n'

    init_state = '(:init\n' + indent(init_state, '\t', lambda line: True) + ')'
    return init_state

#-----------------------------------------------
# Goal
#-----------------------------------------------
def parse_goal(positive_goals, negative_goals):
    goal = ''
    if positive_goals:
        for pgoal in positive_goals:
            goal += f'({pgoal[0]}'
            if (len(pgoal) > 1):
                for obj in pgoal[1:]:
                    goal += f' {obj}'
            goal += ')\n'

    if (negative_goals):
        for ngoal in negative_goals:
            goal += f'(not ({ngoal[0]}'
            if (len(ngoal) > 1):
                for obj in ngoal[1:]:
                    goal += f' {obj}'
            goal += '))\n'

    goal = '(and\n' + indent(goal, '\t', lambda line: True) + ')\n'
    goal = '(:goal\n' + indent(goal, '\t', lambda line: True) + ')'
    return goal

#-----------------------------------------------
# Metric
#-----------------------------------------------
def parse_metric(metric):
    if not metric:
        return ''
    return f"(:metric {metric[0]} {array_to_predicate(metric[1])})"

def array_to_predicate(arr):
    predicate = '('
    for elem in arr:
        if not isinstance(elem, list):
            predicate += f"{elem} "
        else:
            predicate += array_to_predicate(elem)
    predicate += ') '
    return predicate

#-----------------------------------------------
# Save files
#-----------------------------------------------
def save_files(domain_filename, problem_filename, domain, problem, enable_output):
    if domain is None:
        raise Exception('Domain creation was unsuccessful')
    if problem is None:
        raise Exception('Problem creation was unsuccessful')
    
    directory, filename = os.path.split(domain_filename)
    filename, extension = os.path.splitext(filename)
    domain_file = f'{directory}/{filename}-follow-plan.pddl'
    
    with open(domain_file, "w") as file:
        file.write(domain)
        file.close()

    directory, filename = os.path.split(problem_filename)
    filename, extension = os.path.splitext(filename)
    problem_file = f'{directory}/{filename}-follow-plan.pddl'
    with open(problem_file, "w") as file:
        file.write(problem)
        file.close()

    if enable_output:
        print('Domain and problem files successfully created')
        print(f'Created files:\t{domain_file}\t{problem_file}')


#-----------------------------------------------
# Main
#-----------------------------------------------
def parse(domain_filename, problem_filename, plan_filename, enable_output=False):
    parser = PDDL_Parser()

    eol = '\n'

    # ------
    # DOMAIN
    # ------ 
    parser.parse_domain(domain_filename)

    domain = f'(define '
    domain += f'{parse_domain_name(parser.domain_name)}{eol}'
    domain += f'{parse_requirements(parser.requirements)}{eol}'
    domain += f'{parse_types(parser.types)}{eol}'
    domain += f'{parse_predicates(parser.predicates, parser.actions)}{eol}'
    domain += f'{parse_functions(parser.functions)}{eol}'
    domain += f'{parse_actions(parser.actions)}{eol}'
    domain += ')'

# ----
    # PLAN
    # ----
    plan = parser.parse_plan(plan_filename)

    # -------
    # PROBLEM
    # -------
    parser.parse_problem(problem_filename)

    problem = f'(define '
    problem += f'{parse_problem_name(parser.problem_name)}{eol}'
    problem += f'{parse_problem_domain(parser.domain_name)}{eol}'
    problem += f'{parse_objects(parser.objects, plan)}{eol}'
    problem += f'{parse_init(parser.state, plan)}{eol}'
    problem += f'{parse_goal(parser.positive_goals, parser.negative_goals)}{eol}'
    problem += f'{parse_metric(parser.metric)}{eol}'
    problem += ')'

    save_files(domain_filename, problem_filename, domain, problem, enable_output)

if __name__ == "__main__":
    parse(sys.argv[1], sys.argv[2], sys.argv[3])



    