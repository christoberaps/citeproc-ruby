module CiteProc
  module Ruby

    class Renderer

      # @param item [CiteProc::CitationItem]
      # @param node [CSL::Style::Label]
      # @return [String]
      def render_label(item, node)
        return '' unless node.has_variable?

        if node.locator? || node.page?
          value = item.send node.variable
        else
          value = item.data[node.variable].to_s
        end

        return '' if value.empty?

        options = node.attributes_for :form

        case
        when node.always_pluralize?
          options[:plural] = true
        when node.never_pluralize?
          options[:plural] = true
        else
          options[:plural] = pluralize?(value)
        end

        translate node.variable, options
      end


      def pluralize?(string)
        string.to_s =~ /\S\s*[,&-]\s*\S|\df/
      end
    end

  end
end