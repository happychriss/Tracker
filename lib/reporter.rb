module Reporter

  TaskListItem=Struct.new(:task_id, :type_list)

  

  class SumTask < Object

    def initialize(task_list, type_list)
      @type_list=type_list
      @task_list=task_list

      @baseline_cost=BaseRequest.total_cost(:baseline,task_list)
      @estimation_cost=BaseRequest.total_cost(:estimation,task_list)

      @diff =@estimation_cost[:eac]- @baseline_cost[:eac]  
    end

    attr_reader :diff,
                :type_list,
                :task_list,
                :cost,
                :baseline_cost,
                :estimation_cost

    # object: baseline or estimate, type: eac, eac_mean to be compatible with sparkline
    def cost(object, type)
        self.send(object.to_s+'_cost')[type]
    end

    def cost_short(object, type)
    self.cost(object,type).to_s(:cents => false)
    end
    
  end

  ## internal object used to calculate the report_types array, each call
  ##n next_position return the next item for the relevant position      xx
  class Position < Object

    def initialize(report, position)
      @position = position
      @types = report.get_types_by_position(position)
      @anz_types = @types.count
      @counter = 0
      @repeat_counter = 0
      @report=report
      @repeat = report.get_repeat_for_position(position)
      @initial_empty = report.get_empty_for_position(position)
      @initial_empty_counter = 0

      if @initial_empty == 0 then
        @first = false
      else
        @first = true
      end
    end


    def next_position

      if @first then
        @initial_empty_counter=@initial_empty_counter+1
        @first = false if @initial_empty_counter == @initial_empty
        return 0
      end

      res = @types[@counter]


      @repeat_counter = @repeat_counter+1

      # commplete one item , e.g. cons, cons, cons <--- , staff, staff, staff, hw, hw, hw
      if @repeat_counter == @repeat then
        @counter=@counter+1
        @repeat_counter = 0

      end

      if @counter == @anz_types then
        @first = false
        @repeat_counter = 0
        @counter = 0

      end

      return res

    end

  end



end

