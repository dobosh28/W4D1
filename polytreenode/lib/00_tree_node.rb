class PolyTreeNode
    attr_reader :parent, :children, :value
    attr_writer :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(daddy)
        if daddy && @parent # reassigning
            @parent.children.delete(self)
            daddy.children << self
        elsif daddy.nil? && @parent
            @parent.children.delete(self)
        elsif !daddy.children.include?(self)
            daddy.children << self
        end
        @parent = daddy
    end

    def add_child(child)
      child.parent=(self)
    end

    def remove_child(child)
      child.parent=(nil)
    end

    def inspect
      "Val: #{@value} | Parent: #{@parent ? @parent.value : 'none'} | Children: #{@children.map{|child| child.value}}"
    end

    def dfs(target)
        # return nil if self.children.empty? && self.value != target
        return self if self.value == target
        self.children.each do |child|
            result = child.dfs(target)
            return result if result
        end
        nil
    end

    def bfs(target)
        queue = []
        queue << self
        until queue.empty? 
            node = queue.shift
            return node if node.value == target
            queue += node.children
        end
        nil
    end
end


