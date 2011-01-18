module Admin

  module FilePreviewHelper

    def get_type_of_attachment(attachment)
      if defined?(Paperclip) && attachment.is_a?(Paperclip::Attachment)
        :paperclip
      elsif defined?(Dragonfly) && attachment.is_a?(Dragonfly::ActiveModelExtensions::Attachment)
        :dragonfly
      elsif defined?(CarrierWave) && attachment.is_a?(CarrierWave::Uploader::Base)
        :carrierwave
      end
    end

    def link_to_detach_attribute(attribute)
      validators = @item.class.validators.delete_if { |i| i.class != ActiveModel::Validations::PresenceValidator }.map { |i| i.attributes.to_s }.flatten

      attachment = @item.send(attribute)

      field = case get_type_of_attachment(attachment)
                 when :dragonfly then attribute
                 when :paperclip then "#{attribute}_file_name"
                 when :carrierwave then attribute
                 end

      if !validators.include?(field) && attachment
        attribute_i18n = @item.class.human_attribute_name(attribute)
        message = Typus::I18n.t("Remove %{attribute}", :attribute => attribute_i18n)
        label_text = <<-HTML
#{attribute_i18n}
<small>#{link_to message, { :action => 'detach', :id => @item.id, :attribute => attribute }, :confirm => Typus::I18n.t("Are you sure?")}</small>
        HTML
        label_text.html_safe
      end
    end

    def typus_file_preview(item, attribute)
      if (attachment = item.send(attribute))
        case get_type_of_attachment(attachment)
        when :dragonfly
          typus_file_preview_for_dragonfly(attachment)
        when :paperclip
          typus_file_preview_for_paperclip(attachment)
        when :carrierwave
          typus_file_preview_for_carrierwave(attachment)
        end
      end
    end

    def typus_file_preview_for_dragonfly(attachment)
      if attachment.mime_type =~ /^image\/.+/
        render "admin/helpers/file_preview",
               :preview => attachment.process(:thumb, Typus.image_preview_size).url,
               :thumb => attachment.process(:thumb, Typus.image_thumb_size).url
      else
        link_to attachment.name, attachment.url
      end
    end

    def typus_file_preview_for_paperclip(attachment)
      if attachment.exists?
        styles = attachment.styles.keys
        if styles.include?(Typus.file_preview) && styles.include?(Typus.file_thumbnail)
          render "admin/helpers/file_preview",
                 :preview => attachment.url(Typus.file_preview, false),
                 :thumb => attachment.url(Typus.file_thumbnail, false)
        else
          link_to attachment.original_filename, attachment.url(:original, false)
        end
      end
    end
    
    def typus_file_preview_for_carrierwave(attachment)
      if attachment.file
        versions = attachment.versions.keys
        if versions.include?(Typus.carrierwave_preview) && versions.include?(Typus.carrierwave_thumb)
          render "admin/helpers/file_preview",
                 :preview => attachment.send(Typus.carrierwave_preview).url,
                 :thumb => attachment.send(Typus.carrierwave_thumb).url
        else
          link_to attachment.file.original_filename, attachment.url
        end
      end
    end

  end

end
