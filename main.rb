module Strategy
    class NoStrategyError < StandardError
    end 
    class NoStrategyMethodError < StandardError
    end
    class Context
        def initialize
            @strategy = nil 
        end 

        def set_strategy(strategy)
            @strategy = strategy
        end 

        def method_missing(method)
            find_method = false
            if @strategy
                @strategy.methods.each {|param| param == method ? find_method = true : next }
                if find_method
                    @strategy.send(method)
                else
                    raise NoStrategyMethodError.new("this method '#{method}' was not found in an instance of this strategy - #{@strategy}")
                end
            else 
                raise NoStrategyError.new("the strategy was not chosen, use method 'set_strategy' for chose strategy")
            end 
        end
    end 
end



class Strategy1
    def hello
        print("hello world")
    end
end
class Strategy2 
end
cont = Strategy::Context.new

cont.set_strategy(Strategy1.new)
cont.hello

cont.set_strategy(Strategy2.new)
cont.hello
