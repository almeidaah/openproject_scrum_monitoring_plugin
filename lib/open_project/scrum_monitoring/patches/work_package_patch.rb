require_dependency 'work_package'

module OpenProject::ScrumMonitoring::Patches::WorkPackagePatch
  def self.included(base)
      base.class_eval do
       include InstanceMethods
      end
  end

  module InstanceMethods

    def commited_lines
      return branches.sum(:diff) unless branches.sum(:diff).nil?
      0
    end

    def estimated_lines
      calculate(calculated_estimated_time, self.project.productivity_average) do 
        calculated_estimated_time * self.project.productivity_average
      end 
    end

    def calculated_lines_percentage      
      calculate(commited_lines, estimated_lines) do 
        (commited_lines.fdiv(estimated_lines) * 100.0).floor 
      end           
    end

    def calculated_hours_percentage     
      calculate(spent_hours, fixed_estimated_hours) do 
        (spent_hours.fdiv(fixed_estimated_hours) * 100.0).floor 
      end        
    end

    def calculated_productivity 
      calculate(commited_lines, spent_hours) do 
        commited_lines.fdiv(spent_hours)   
      end
    end

    def projected_lines      
      calculate(commited_lines, done_ratio) do 
        (commited_lines*100).fdiv(done_ratio) 
      end      
    end

    def projected_hours
      calculate(spent_hours, done_ratio) do 
        (spent_hours*100).fdiv(done_ratio) 
      end      
    end

    def ticket_size
      calculate(self.project.productivity_average, fixed_estimated_hours) do 
        self.project.productivity_average * fixed_estimated_hours
      end      
    end

    def inspection_preparation_time
      calculate(ticket_size, self.project.inspection_preparation_average) do 
        (ticket_size / self.project.inspection_preparation_average) * 60 * 60 
      end      
    end

    def inspection_time
      calculate(ticket_size, self.project.inspection_average) do
        (ticket_size / self.project.inspection_average) * 60 * 60 
      end
    end

    def inspection_rework_time
      calculate(ticket_size, self.project.rework_average) do 
        (ticket_size / self.project.rework_average) * 60 * 60 
      end      
    end

    def correction_factor
      #correction_factors.where(:tracker_id => self.tracker.id, :complexity => complexity).first.value      
    end

    private 

    def calculate(x, y)
      if x && x != 0 && y != 0 && y 
        yield 
      else
        0
      end
    end

    def fixed_estimated_hours
      return estimated_hours unless estimated_hours.nil?
      0
    end

    def correction_factors
      self.project.correction_factors
    end

    def complexity
      self.custom_field_values.find {|s| s.custom_field.name == 'Complexity'}.value
    end

    def calculated_estimated_time 
      fixed_estimated_hours * correction_factor
    end
  end
end

WorkPackage.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagePatch)
