class AdminAssistant
  class PolymorphicBelongsToColumn < Column
    def initialize(belongs_to_assoc)
      @belongs_to_assoc = belongs_to_assoc
    end
    
    def add_to_query_condition(ar_query_condition, search)
      kv = (key_value = search.send(association_foreign_key)) && 
           !key_value.blank?
      tv = (type_value = search.send(foreign_type_field)) &&
           !type_value.blank?
      if kv and tv
        ar_query_condition.add_condition do |subcond|
          subcond.boolean_join = :and
          subcond.sqls << "#{association_foreign_key} = ?"
          subcond.bind_vars << key_value
          subcond.sqls << "#{foreign_type_field} = ?"
          subcond.bind_vars << type_value
        end
      end
    end
    
    def association_foreign_key
      @belongs_to_assoc.association_foreign_key
    end
    
    def attributes_for_search_object(search_params)
      atts = {}
      atts[association_foreign_key.to_sym] = 
          search_params[association_foreign_key]
      atts[foreign_type_field.to_sym] = search_params[foreign_type_field]
      if !atts[foreign_type_field.to_sym].blank?
        atts[name.to_sym] = Module.const_get(
          search_params[foreign_type_field]
        ).find_by_id(search_params[association_foreign_key])
      else
        atts[name.to_sym] = nil
      end
      atts
    end
    
    def contains?(column_name)
      column_name.to_s == name
    end
      
    def foreign_type_field
      @belongs_to_assoc.options[:foreign_type]
    end
    
    def match_text_fields_in_search
      false
    end
    
    def name
      @belongs_to_assoc.name.to_s
    end
    
    class View < AdminAssistant::Column::View
      def assoc_value(assoc_value)
        if assoc_value.respond_to?(:name_for_admin_assistant)
          assoc_value.name_for_admin_assistant
        elsif assoc_value
          association_target = AssociationTarget.new assoc_value.class
          if dnm = association_target.default_name_method
            assoc_value.send dnm
          end
        end
      end
      
      def value(record)
        record.send name
      end
    end
    
    class FormView < View
      include AdminAssistant::Column::FormViewMethods
      
      def html(form)
        opts_for_select = @polymorphic_types.map { |t| [t.name, t.name] }
        form.select(name + '_type', opts_for_select, @select_options) + " " +
            form.text_field(name + '_id', :class => 'integer')
      end
    end

    class IndexView < View
      include AdminAssistant::Column::IndexViewMethods
      
      def value(record)
        target = record.send name
        if target
          str = AssociationTarget.new(target.class).name.capitalize
          fv = assoc_value target
          if fv
            str << " '#{fv}'"
          else
            str << " #{target.id}"
          end
        end
      end
    end
    
    class SearchView < View
      include AdminAssistant::Column::SearchViewMethods
      
      def html(form)
        @action_view.send(
          :render,
          :file => AdminAssistant.template_file('_polymorphic_field_search'),
          :use_full_path => false,
          :locals => {
            :record => @search, :column => @column,
            :polymorphic_types => @polymorphic_types
          }
        )
      end
    end
    
    class ShowView < View
      include AdminAssistant::Column::ShowViewMethods
    end
  end
end
