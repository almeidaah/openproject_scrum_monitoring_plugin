module BranchesHelper
  # Returns a comma separated list of users watching the given issue
  def branches_list(branches)
    #remove_allowed = User.current.allowed_to?("delete_#{issue.class.name.underscore}_watchers".to_sym, issue.project)
    content = ''.html_safe
    branches.each do |branch|
      @repository = CounterRepository.find(branch.counter_repository_id)
      s = ''.html_safe
      url = {:controller => 'branches',
             :action => 'destroy',
             :work_package_id => branch.work_package,
             :branch_id => branch}
      s << @repository.name << " - "       
      s << "#{branch.name} ".html_safe
      s << " | ".html_safe 
      s << "#{branch.diff}"
      s << " lines".html_safe
      s << link_to(l(:button_delete), url, :confirm => l(:text_are_you_sure), :method => :delete, :class => 'icon icon-delete')
      
      #end
      content << content_tag('li', s, :class => "branch-#{branch.id}", :id =>"work_package_branch_id_#{branch.id}")
    end
    content.present? ? content_tag('ul', content, :class => 'branches') : content
  end

end