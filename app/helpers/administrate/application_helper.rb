module Administrate
  module ApplicationHelper
    def render_field(field, locals = {})
      locals.merge!(field: field)
      render locals: locals, partial: field.to_partial_path
    end

    def display_resource_name(resource_name)
      resource_name.
        to_s.
        classify.
        constantize.
        model_name.
        human(
          count: 0,
          default: resource_name.to_s.pluralize.titleize,
        )
    end

    def svg_tag(asset, options = {})
      svg_id = options.fetch(:svg_id)

      svg_attributes = {
      "xlink:href".freeze => "#{asset_url(asset)}##{svg_id}",
      }

      svg_schema = "http://www.w3.org/2000/svg".freeze
      xlink_schema = "http://www.w3.org/1999/xlink".freeze

      svg_attributes[:width] = options[:width] if options[:width]
      svg_attributes[:height] = options[:height] if options[:height]

      content_tag :svg,
                   xmlns: svg_schema,
                   "xmlns:xlink".freeze => xlink_schema do
        content_tag :use, nil, svg_attributes
      end
    end
  end
end
