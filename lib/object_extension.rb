
module ObjectExtension
  def nil_or
    return self unless self.nil? 
    Class.new do
      def method_missing(sym, *args); nil; end
    end.new
  end  
end

class Object
  include ObjectExtension
end
