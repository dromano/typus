module Typus

  module Orm

    module ClassMethods

      # Model fields as an <tt>ActiveSupport::OrderedHash</tt>.
      def model_fields
        ActiveSupport::OrderedHash.new.tap do |hash|
          columns.map { |u| hash[u.name.to_sym] = u.type.to_sym }
        end
      end

      # Model relationships as an <tt>ActiveSupport::OrderedHash</tt>.
      def model_relationships
        ActiveSupport::OrderedHash.new.tap do |hash|
          reflect_on_all_associations.map { |i| hash[i.name] = i.macro }
        end
      end

      # Model description for admin panel.
      def typus_description
        read_model_config['description']
      end

      # Form and list fields
      def typus_fields_for(filter)
        ActiveSupport::OrderedHash.new.tap do |fields_with_type|
          data = read_model_config['fields']
          fields = data[filter.to_s] || data['default'] || ""

          virtual_fields = instance_methods - model_fields.keys.map { |i| i.to_s }
          
          fields.extract_settings.map { |f| f.to_sym }.each do |field|
            if reflect_on_association(field)
              fields_with_type[field.to_s] = reflect_on_association(field).macro
              next
            end

            if typus_field_options_for(:selectors).include?(field)
              fields_with_type[field.to_s] = :selector
              next
            end

            dragonfly = respond_to?(:dragonfly_apps_for_attributes) && dragonfly_apps_for_attributes.try(:has_key?, field)
            paperclip = respond_to?(:attachment_definitions) && attachment_definitions.try(:has_key?, field)
            carrierwave = method_defined?("#{field}_processing_error".to_sym) && method_defined?("#{field}_integrity_error".to_sym)
            
            
            if dragonfly || paperclip || carrierwave
              fields_with_type[field.to_s] = :file
              next
            end

            if virtual_fields.include?(field.to_s)
              fields_with_type[field.to_s] = :virtual
            end

            fields_with_type[field.to_s] = case field.to_s
                                           when 'parent', 'parent_id' then :tree
                                           when /password/            then :password
                                           when 'position'            then :position
                                           when /\./                  then :transversal
                                           else
                                             if fields_with_type[field.to_s]
                                               fields_with_type[field.to_s]
                                             else
                                               model_fields[field]
                                             end
                                           end

          end
        end
      end

      def typus_filters
        ActiveSupport::OrderedHash.new.tap do |fields_with_type|
          if data = read_model_config['filters']
            data.extract_settings.map { |i| i.to_sym }.each do |field|
              attribute_type = model_fields[field.to_sym]
              if reflect_on_association(field.to_sym)
                attribute_type = reflect_on_association(field.to_sym).macro
              end
              fields_with_type[field.to_s] = attribute_type
            end
          end
        end
      end

      # Extended actions for this model on Typus.
      def typus_actions_on(filter)
        actions = read_model_config['actions']
        actions && actions[filter.to_s] ? actions[filter.to_s].extract_settings : []
      end

      # Used for +search+, +relationships+
      def typus_defaults_for(filter)
        read_model_config[filter.to_s].try(:extract_settings) || []
      end

      def typus_search_fields
        Hash.new.tap do |search|
          typus_defaults_for(:search).each do |field|
            if field.starts_with?("=")
              field.slice!(0)
              search[field] = "="
            elsif field.starts_with?("^")
              field.slice!(0)
              search[field] = "^"
            else
              search[field] = "@"
            end
          end
        end
      end

      def typus_application
        read_model_config['application'] || 'Unknown'
      end

      def typus_field_options_for(filter)
        options = read_model_config['fields']['options']
        options && options[filter.to_s] ? options[filter.to_s].extract_settings.map { |i| i.to_sym } : []
      end

      #--
      # With Typus::Resources we some application defaults.
      #
      #     Typus::Resources.setup do |config|
      #       config.per_page = 15
      #     end
      #
      # If for any reason we need a better default for an specific resource we
      # we override it on `application.yaml`.
      #
      #     Post:
      #       ...
      #       options:
      #         per_page: 15
      #++
      def typus_options_for(filter)
        options = read_model_config['options']

        unless options.nil? || options[filter.to_s].nil?
          options[filter.to_s]
        else
          Typus::Resources.send(filter)
        end
      end

      def typus_export_formats
        read_model_config['export'].try(:extract_settings) || []
      end

      def typus_order_by
        typus_defaults_for(:order_by).map do |field|
          field.include?('-') ? "#{table_name}.#{field.delete('-')} DESC" : "#{table_name}.#{field} ASC"
        end.join(', ')
      end

      #--
      # Define our own boolean mappings.
      #
      #     Post:
      #       fields:
      #         default: title, status
      #         options:
      #           booleans:
      #             status: "Published", "Not published"
      #
      #++
      def typus_boolean(attribute = :default)
        options = read_model_config['fields']['options']

        boolean = if options && options['booleans'] && boolean = options['booleans'][attribute.to_s]
                    boolean.is_a?(String) ? boolean.extract_settings : boolean
                  else
                    ["True", "False"]
                  end

        { boolean.first => "true", boolean.last => "false" }
      end

      #--
      # Custom date formats.
      #++
      def typus_date_format(attribute = :default)
        options = read_model_config['fields']['options']
        if options && options['date_formats'] && options['date_formats'][attribute.to_s]
          options['date_formats'][attribute.to_s].to_sym
        else
          :default
        end
      end

      #--
      # This is user to use custome templates for attribute:
      #
      #     Post:
      #       fields:
      #         form: title, body, status
      #         options:
      #           templates:
      #             body: rich_text
      #
      # Templates are stored on <tt>app/views/admin/templates</tt>.
      #++
      def typus_template(attribute)
        options = read_model_config['fields']['options']
        if options && options['templates'] && options['templates'][attribute.to_s]
          options['templates'][attribute.to_s]
        end
      end

      def adapter
        @adapter ||= ActiveRecord::Base.configurations[Rails.env]['adapter']
      end

      def typus_user_id?
        columns.map { |u| u.name }.include?(Typus.user_fk)
      end

      def read_model_config
        Typus::Configuration.config[name] or raise "No typus configuration specified for #{name}"
      end

    end

    module InstanceMethods
      
      def owned_by?(user)
        send(Typus.user_fk) == user.id
      end

    end

  end

end

if defined?(ActiveRecord)
  require 'typus/orm/active_record/search'
  ActiveRecord::Base.extend Typus::Orm::ClassMethods
  ActiveRecord::Base.extend Typus::Orm::ClassMethods::Search
  ActiveRecord::Base.send :include, Typus::Orm::InstanceMethods
end
