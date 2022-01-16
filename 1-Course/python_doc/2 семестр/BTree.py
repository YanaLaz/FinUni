class BinaryTree:
    def __init__(self, root=None):
        self.key = root
        self.left_child = None
        self.right_child = None

    def insert_left(self, new_node=None):
        if self.left_child is None:
            self.left_child = BinaryTree(new_node)
        else:
            t = BinaryTree(new_node)
            t.left_child = self.left_child
            self.left_child = t

    def insert_right(self, new_node=None):
        if self.right_child is None:
            self.right_child = BinaryTree(new_node)
        else:
            t = BinaryTree(new_node)
            t.right_child = self.right_child
            self.right_child = t

    def get_right_child(self):
        return self.right_child

    def get_left_child(self):
        return self.left_child

    def set_root_val(self, obj):
        self.key = obj

    def get_root_val(self):
        return self.key

    def line_print_tree(self, start, count=0):
        if start is None:
            return None
        if start:
            count += 1
            print('-' * 2 * count, start.get_root_val())
            count += 1
            self.line_print_tree(start.get_left_child(), count)
            self.line_print_tree(start.get_right_child(), count)

    def del_Nones(self):
        if not self.get_left_child() is None and self.get_left_child().get_root_val() is None:
            self.left_child = None
        if not self.get_right_child() is None and self.get_right_child().get_root_val() is None:
            self.right_child = None
        if not self.get_left_child() is None:
            self.get_left_child().del_Nones()
        if not self.get_right_child() is None:
            self.get_right_child().del_Nones()

    def preorder_print(self, start):
        if start:
            print(start.get_root_val())
            start.preorder_print(start.get_left_child())
            start.preorder_print(start.get_right_child())

    def postorder_print(self):
        if self:
            if not self.get_left_child() is None:
                self.get_left_child().postorder_print()
            if not self.get_right_child() is None:
                self.get_right_child().postorder_print()
            print(self.get_root_val())

    def inorder_print(self, start):
        if start:
            start.inorder_print(start.get_left_child())
            print(start.get_root_val())
            start.inorder_print(start.get_right_child())

    def input_f_tree(self, elem):
        if self.get_root_val() is None:
            self.set_root_val(elem)
        elif int(self.get_root_val()) <= elem:
            if self.get_right_child() is None:
                self.insert_right(elem)
            else:
                self.get_right_child().input_f_tree(elem)
        elif int(self.get_root_val()) > elem:
            if self.get_left_child() is None:
                self.insert_left(elem)
            else:
                self.get_left_child().input_f_tree(elem)

    def find(self, start, elem):
        if start is None:
            return None
        if elem == int(start.get_root_val()):
            return start
        elif start.get_root_val() <= elem:
            return start.find(start.get_right_child(), elem)
        elif start.get_root_val() > elem:
            return start.find(start.get_left_child(), elem)
        return None

    def delete_elem_tree(self, tree, elem):
        del_elem = self.find(tree, elem)
        if del_elem is None:
            return None
        elif del_elem.get_left_child() is None and del_elem.get_right_child() is None:
            del_elem.set_root_val(None)
            self.del_Nones()
        elif del_elem.get_left_child() is None:
            del_elem.key = del_elem.get_right_child().get_root_val()
            del_elem.left_child = del_elem.get_right_child().get_left_child()
            del_elem.right_child = del_elem.get_right_child().get_right_child()
        elif del_elem.get_right_child() is None:
            del_elem.key = del_elem.get_left_child().get_root_val()
            del_elem.right_child = del_elem.get_left_child().get_right_child()
            del_elem.left_child = del_elem.get_left_child().get_left_child()
        else:
            right_elem = del_elem.get_right_child()
            max_left = None
            while True:
                if right_elem.get_left_child() is None:
                    if max_left is None:
                        max_left = right_elem
                    del_elem.key = max_left.get_root_val()
                    self.delete_elem_tree(right_elem, max_left.get_root_val())  # 1 arg = right_elem
                    break
                else:
                    max_left = right_elem.get_left_child()
                    right_elem = right_elem.get_left_child()

    def calc(self):
        if self.key == '/':
            return self.get_left_child().calc() / self.get_right_child().calc()
        elif self.key == '*':
            return self.get_left_child().calc() * self.get_right_child().calc()
        elif self.key == '+':
            return self.get_left_child().calc() + self.get_right_child().calc()
        elif self.key == '-':
            return self.get_left_child().calc() - self.get_right_child().calc()
        return self.key

    def __str__(self):
        return '{} ({}, {})'.format(self.get_root_val(), str(self.get_left_child()), str(self.get_right_child()))
