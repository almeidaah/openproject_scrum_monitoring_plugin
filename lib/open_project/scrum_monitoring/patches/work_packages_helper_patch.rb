require_dependency 'work_packages_helper'

module OpenProject::ScrumMonitoring::Patches::WorkPackagesHelperPatch
  def self.included(base)
    base.module_eval do

         ################################################################################ => 
         ################################################################################
         ################################################################################
         #########CAMPOS PERSONALIZADOS DO RELATÓRIO DE ACMOPANHAMENTO DA SPRINT#########
         ################################################################################
         ################################################################################
         ################################################################################
         
         def calculated_estimated_time(estimated_hours, complexity, subtype,  context_id) 
            return estimated_hours * correction_factor(complexity, subtype, context_id)
         end

         def spent_time(issue_id)
              cond = ARCondition.new

              cond << "#{WorkPackage.table_name}.id = #{issue_id}"
              @total_hours = TimeEntry.visible.sum(:hours, include: [:project, :work_package], conditions: cond.conditions).to_f
              return @total_hours
         end

         def calculated_hours_percentage (work_package)    
            spent_hours = spent_time(work_package.id)
            estimated_hours = work_package.estimated_hours
            calculate(spent_hours, estimated_hours) do 
              (spent_hours.fdiv(estimated_hours) * 100.0).floor 
            end        
         end

         def calculated_lines_percentage(commited_lines, estimated_lines)    
            calculate(commited_lines, estimated_lines) do 
              (commited_lines.fdiv(estimated_lines) * 100.0)
            end           
          end

         def calculated_productivity (commited_lines, spent_hours)
            calculate(commited_lines, spent_hours) do 
              commited_lines.fdiv(spent_hours)   
          end
    end



         ################################################################################
         ################################################################################
         ################################################################################
         #################################CAMPOS ADICIONAIS WORK PACKAGES################
         ################################################################################
         ################################################################################
         ################################################################################

        def ticket_size(work_package)
            @groupversion = GroupVersion.where(:version_id => work_package.fixed_version_id)
            @context = Context.where(:id => @groupversion[0].context_id)
            return work_package.estimated_hours * @context[0].productivity_average.to_f
        end

        def inspection_preparation_time(work_package)
          ticket_size_lines = ticket_size(work_package) 
          inspection_preparation_average_value = context[0].inspection_preparation_average.to_f
          calculate(ticket_size_lines , inspection_preparation_average_value) do 
            return (ticket_size_lines / inspection_preparation_average_value)
          end 
        end

        def inspection_time(work_package)
          ticket_size_lines = ticket_size(work_package)
          inspection_duration_average_value = context[0].inspection_duration_average.to_f
          calculate(ticket_size_lines, inspection_duration_average_value) do 
              return (ticket_size_lines / inspection_duration_average_value)
          end 
        end

        def rework_time(work_package)
          ticket_size_lines = ticket_size(work_package)
          rework_average_value = context[0].rework_average.to_f
          calculate(ticket_size_lines, rework_average_value) do 
              return (ticket_size_lines / rework_average_value)
          end 
        end

        def total_time(work_package)
          customFieldValues = CustomValue.where(:customized_id => work_package.id)
          context_id = @groupversion[0].context_id
          @context = Context.where(:id => context_id)

          
          complexity = customFieldValues[1]
          subtype = customFieldValues[0]

          total_hours = work_package.estimated_hours*correction_factor(complexity, subtype, context_id)
          
          return total_hours + inspection_preparation_time(work_package) + inspection_time(work_package) + rework_time(work_package)
        end

        def calculate(x, y)
          if x && x != 0 && y != 0 && y 
            yield 
          else
            0
          end
        end

        def correction_factor(complexity, subtype,  context_id)
          cf = CorrectionFactor.where(:complexity => complexity.to_s, :type_id => subtype.to_s, :context_id => context_id)
          unless cf[0].nil?
            return cf[0].value
          end
            return 0
        end

        def context
          Context.where(:id => @groupversion[0].context_id)
        end

    end
  end
end

WorkPackagesHelper.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagesHelperPatch)
