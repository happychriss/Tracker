class Date

def self.next_monday(d1)
   dw=d1
   dw +=1 while (dw.wday != 1)
   return dw
  end
   
  def self.last_monday(d1)
     dw=d1
      dw -=1 while (dw.wday != 1)
    return dw 
  end
  


def self.today
   new(2011, 02, 10)
end



end