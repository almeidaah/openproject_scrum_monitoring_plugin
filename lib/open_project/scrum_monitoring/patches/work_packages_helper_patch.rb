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
         
         def estimated_lines(estimated_hours, complexity, subtype,  context_id)
            @context = Context.where(:id => context_id)
            productivity_average = @context[0].productivity_average.to_f
            calculate(calculated_estimated_time(estimated_hours, complexity, subtype, context_id), productivity_average) do 
              calculated_estimated_time(estimated_hours, complexity, subtype, context_id) * productivity_average
            end 
         end

         def calculated_estimated_time(estimated_hours, complexity, subtype,  context_id) 
            return estimated_hours * correction_factor(complexity, subtype, context_id)
         end

         def spent_time(issue_id)
              cond = ARCondition.new

              cond << "#{WorkPackage.table_name}.id = #{issue_id}"
              puts cond.conditions
              @total_hours = TimeEntry.visible.sum(:hours, include: [:project, :work_package], conditions: cond.conditions).to_f
              return @total_hours
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
          @context = Context.where(:id => @groupversion[0].context_id)
          calculate(ticket_size(work_package), @context[0].inspection_preparation_average.to_f) do 
            return (ticket_size(work_package) / @context[0].inspection_preparation_average.to_f) * 60 * 60 
          end 
        end

        def inspection_time(work_package)
          @context = Context.where(:id => @groupversion[0].context_id)
          calculate(ticket_size(work_package), @context[0].inspection_duration_average.to_f) do 
              return (ticket_size(work_package) / @context[0].inspection_duration_average.to_f) * 60 * 60 
          end 
        end

        def rework_time(work_package)
          @context = Context.where(:id => @groupversion[0].context_id)
          calculate(ticket_size(work_package), @context[0].rework_average.to_f) do 
              return (ticket_size(work_package) / @context[0].rework_average.to_f) * 60 * 60 
          end 
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

    end
  end
end

WorkPackagesHelper.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagesHelperPatch)
