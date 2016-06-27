require_dependency 'issues_controller'

module IssuesControllerPatch

    def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
            unloadable 
            alias_method_chain :show, :related_plugin
        end
    end

    module InstanceMethods
        def show_with_related_plugin           
            @relations = @issue.relations.select {|r| r.other_issue(@issue) && r.other_issue(@issue).visible? }
              
            @query = IssueQuery.new(:name => "_", :filters => { 'relates' => {:operator => "=", :values => [@issue.id]} }, :group_by => :project, :column_names => [:tracker, :subject]) 
            @issue_count_by_group = @query.issue_count_by_group 
            @issues = @query.issues(:order => :id) 
            
            @other_issues = [] 
            @relations.each do |relation| 
                @other_issues << relation.other_issue(@issue) 
            end 
            @other_issues -= @issues 
                        
            show_without_related_plugin
        end
    end
end

# Add module to Issue Relations
IssuesController.send(:include, IssuesControllerPatch)